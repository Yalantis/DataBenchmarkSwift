//
//  LinkedList.swift
//  DataBenchmarkSwift
//
//  Created by Stanislav on 01.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import Foundation

class LinkedList<T: Equatable>: SequenceType {
    private var startNode: LinkedNode<T>?
    
    init() {
        
    }
    
    init(value: T) {
        self.startNode = LinkedNode(value: value)
    }

    func generate() -> LinkedListGenerator<T> {
        return LinkedListGenerator(list: self)
    }
}

class OptimizedLinkedList<T: Equatable>: LinkedList<T> {
    private weak var lastNode: LinkedNode<T>?
    
    override init() {
       super.init()
    }
    
    var last: T? {
        return self.lastNode?.storedValue
    }
    
    override init(value: T) {
        super.init(value: value)
        self.lastNode = self.startNode
    }
    
    func add(value: T) {
        let newNode = LinkedNode(value: value)
        if let node = self.lastNode {
            node.next = newNode
        } else {
            self.startNode = newNode
        }
        self.lastNode = newNode
    }
    
    func removeFirstOccurenceOf(value: T) -> Bool {
        if (self.startNode == nil) {
            return false
        }
        var currentNode = self.startNode
        var prevNode: LinkedNode<T>?
        while (currentNode!.next != nil) {
            if (currentNode!.storedValue == value) {
                if (prevNode == nil) {
                    self.startNode = currentNode!.next
                    if (currentNode!.next == nil) {
                        self.lastNode = self.startNode
                    }
                } else {
                    prevNode!.next = currentNode!.next
                    if (currentNode!.next == nil) {
                        self.lastNode = prevNode
                    }
                }
                
                return true
            }
            prevNode = currentNode
            currentNode = currentNode!.next
        }
        return false
    }
}

class Stack<T: Equatable>: LinkedList<T> {
    
    override init() {
        super.init()
    }
    
    func push(value: T) {
        let newNode = LinkedNode(value: value)
        if (self.startNode != nil) {
            newNode.next = self.startNode
        }
        self.startNode = newNode
    }
    
    func pop() -> T? {
        if (self.startNode == nil) {
            return nil
        }
        
        let outcomeValue = self.startNode!.storedValue
        self.startNode = self.startNode!.next
        
        return outcomeValue
    }
    
}

class Queue<T: Equatable>: OptimizedLinkedList<T> {
    
    override init() {
        super.init()
    }
    
    func dequeue() -> T? {
        if (self.startNode == nil) {
            return nil
        }
        
        let outcomeValue = self.startNode!.storedValue
        self.startNode = self.startNode!.next
        
        return outcomeValue
    }
}

struct LinkedListGenerator<T : Equatable>: GeneratorType {
    let list: LinkedList<T>
    var currentNode: LinkedNode<T>?
    
    init (list: LinkedList<T>) {
        self.list = list
    }
    
    mutating func next() -> T? {
        if (currentNode == nil) {
            self.currentNode = self.list.startNode
        } else {
            self.currentNode = self.currentNode?.next
        }
        
        return self.currentNode?.storedValue
    }
}
