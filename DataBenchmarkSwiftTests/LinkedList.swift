//
//  LinkedList.swift
//  DataBenchmarkSwift
//
//  Created by Stanislav on 01.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import Foundation

class LinkedList<T: Equatable>: SequenceType {
    private var startNode: LinkedNode<T>? {
        didSet {
            self.lastNode = self.startNode
        }
}
    private var lastNode: LinkedNode<T>?
    
    init() {
        
    }
    
    init(value: T) {
        self.startNode = LinkedNode(value: value)
        self.lastNode = self.startNode
    }
    
    var last: T? {
        return self.lastNode?.storedValue
    }
    
    func add(value: T) {
        let newNode = LinkedNode(value: value)
        if let node = self.lastNode {
            node.next = newNode
            self.lastNode = newNode
        } else {
            self.startNode = newNode
        }
    }
    
    func removeFirst(value: T) -> Bool {
        if (self.startNode == nil) {
            return false
        }
        var currentNode = self.startNode
        var prevNode: LinkedNode<T>?
        while (currentNode!.next != nil) {
            if (currentNode!.storedValue == value) {
                if (prevNode == nil) {
                    self.startNode = currentNode!.next
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
    
    func generate() -> LinkedListGenerator<T> {
        return LinkedListGenerator(list: self)
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
