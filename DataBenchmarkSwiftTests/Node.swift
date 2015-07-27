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

enum BinaryNodeType {
    case Left, Right, Root
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

//MARK: Tree

struct DataStorage<T: Comparable, U>: Comparable {
    var key: T
    var value: U
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
    
    private weak var parent: BinaryTreeNode<K, V>?
    private var left: BinaryTreeNode<K, V>?
    private var right: BinaryTreeNode<K, V>?
    
    private var type: BinaryNodeType {
        if (self.parent == nil) {
            return .Root
        }
        if let leftParentChild = self.parent!.left {
            return leftParentChild === self ? .Left : BinaryNodeType.Right
        } else {
            return .Right
        }
    }
    
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
        if (key < self.storedValue.key) {
            self.left?.remove(key)
        } else if (key > self.storedValue.key) {
            self.right?.remove(key)
        } else {
            switch(self.left, self.right) {
            case (.None, .None):
                self.parent = nil
            case (.Some(let left), .None):
                self.storedValue = left.storedValue
                self.left = nil
            case (.None, .Some(let right)):
                self.storedValue = right.storedValue
                self.right = nil
            case (.Some, .Some(let right)):
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

extension BinaryTreeNode {
    
    func rotateRight() {
        switch(self.type) {
        case .Root:
            print("cannot rotate root")
        case .Left:
            self.right?.moveNode(toNode: self.parent!, asLeftChild: true)
            self.parent?.moveNode(toNode: self, asLeftChild: false)
        case .Right:
            print("Right rotation for right branch ins't implemented")
        }
    }
    
    func rotateLeft() {
        switch(self.type) {
        case .Root:
            print("cannot rotate root")
        case .Left:
            print("Left rotation for left branch ins't implemented")
        case .Right:
            self.left?.moveNode(toNode: self.parent!, asLeftChild: false)
            self.parent?.moveNode(toNode: self, asLeftChild: true)
        }
    }
    
    func moveNode(toNode owner: BinaryTreeNode<K, V>, asLeftChild left: Bool) {
        self.parent = owner
        if (self.type == .Left) {
            self.parent!.left = nil
        } else if (self.type == .Right) {
            self.parent!.right = nil
        }
        if (left) {
            owner.left = self
        } else {
            owner.right = self
        }
    }
    
}