//
//  Node.swift
//  DataBenchmarkSwift
//
//  Created by Stanislav on 01.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import Foundation

enum TraverseType {
    case PreOrder, InOrder, PostOrder
}

class Node<T> {
    var storedValue: T
    
    init(value: T) {
        self.storedValue = value
    }
}

class LinkedNode<T>: Node<T> {
    var next: LinkedNode?
    
    override init(value: T) {
        super.init(value: value)
    }
    
    init(value: T, nextLinkedNode node: LinkedNode) {
        super.init(value: value)
        self.next = node
    }
}

struct DataStorage<T: Comparable, U>: Comparable {
    var key: T
    var value: U
    
    init (key: T, value: U) {
        self.key = key
        self.value = value
    }
}

func == <T: Equatable, U> (lhs: DataStorage<T, U>, rhs: DataStorage<T, U>) -> Bool {
    return lhs.key == rhs.key
}

func <= <T: Comparable, U>(lhs: DataStorage<T, U>, rhs: DataStorage<T, U>) -> Bool {
    return lhs.key <= rhs.key
}

func >= <T: Comparable, U>(lhs: DataStorage<T, U>, rhs: DataStorage<T, U>) -> Bool {
    return lhs.key >= rhs.key
}

func < <T: Comparable, U>(lhs: DataStorage<T, U>, rhs: DataStorage<T, U>) -> Bool {
    return lhs.key < rhs.key
}

class BinaryTreeNode<K: Comparable, V>: Node<DataStorage<K, V>> {
    
    private var parent: BinaryTreeNode<K, V>?
    private var left: BinaryTreeNode<K, V>?
    private var right: BinaryTreeNode<K, V>?
    
    override init(value: DataStorage<K, V>) {
        super.init(value: value)
    }
    
    func insert(storage: DataStorage<K, V>) {
        if (storage == self.storedValue) {
            return
        }
        
        if (storage < self.storedValue) {
            if (self.left == nil) {
                self.left = BinaryTreeNode(value: storage)
            } else {
                self.left!.insert(storage)
            }
        } else {
            if (self.right == nil) {
                self.right = BinaryTreeNode(value: storage)
            } else {
                self.right!.insert(storage)
            }
        }
    }
    
    func find(key: K) -> V? {
        if (key == self.storedValue.key) {
            return storedValue.value
        }
        
        if (key < self.storedValue.key && self.left != nil) {
            return self.left!.find(key)
        } else if (key > self.storedValue.key && self.right != nil) {
            return self.right!.find(key)
        }
        return nil
    }
    
    func remove(key: K) {
        if (key == self.storedValue.key) {
            switch(self.left, self.right) {
            case let(.None, .None):
                self.parent = nil
            case let(.Some(left), .None):
                self.storedValue = left.storedValue
                self.left = nil
            case let(.None, .Some(right)):
                self.storedValue = right.storedValue
                self.right = nil
            case let(.Some(left), .Some(right)):
                let successor = right.findMinNode()
                self.storedValue = successor.storedValue
                successor.remove(successor.storedValue.key)
            }
        }
    }
    
    func traverse(type: TraverseType, callback: (storage: DataStorage<K, V>) -> Void) {
        switch (type) {
        case .InOrder:
            self.left?.traverse(type, callback: callback)
            callback(storage: self.storedValue)
            self.right?.traverse(type, callback: callback)
        case .PreOrder:
            callback(storage: self.storedValue)
            self.left?.traverse(type, callback: callback)
            self.right?.traverse(type, callback: callback)
        case .PostOrder:
            self.left?.traverse(type, callback: callback)
            self.right?.traverse(type, callback: callback)
            callback(storage: self.storedValue)
        }
    }
    
    private func findMinNode() -> BinaryTreeNode<K, V> {
        if (self.left == nil) {
            return self
        } else {
            return self.left!.findMinNode()
        }
    }
    
}