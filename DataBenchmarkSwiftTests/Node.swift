//
//  Node.swift
//  DataBenchmarkSwift
//
//  Created by Stanislav on 01.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import Foundation

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
    
    func insert(value: DataStorage<K, V>) {
        if (value.key == self.storedValue.key) {
            return
        }
        
        if (value < self.storedValue) {
            if (self.left == nil) {
                self.left = BinaryTreeNode(value: value)
            } else {
                self.left!.insert(value)
            }
        } else {
            if (self.right == nil) {
                self.right = BinaryTreeNode(value: value)
            } else {
                self.right!.insert(value)
            }
        }
    }
    
    func find(storage: DataStorage<K, V>) -> V? {
        if (storage == self.storedValue) {
            return storedValue.value
        }
        
        if (storage < self.storedValue) {
            if (self.left == nil) {
                return nil
            } else {
                return self.left!.find(storage)
            }
        } else {
            if (self.right == nil) {
                return nil
            } else {
                return self.right!.find(storage)
            }
        }
        
    }
    
}