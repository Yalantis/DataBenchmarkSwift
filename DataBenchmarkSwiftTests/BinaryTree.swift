//
//  BinarySearchTree.swift
//  DataBenchmarkSwift
//
//  Created by Stanislav on 03.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import Foundation

class BinarySearchTree<K: Comparable, V> {
    private var root: BinaryTreeNode<K, V>?
    
    func insert(storage: DataStorage<K, V>) {
        if (self.root == nil) {
            self.root = BinaryTreeNode(value: storage)
        } else {
            self.root!.insert(storage: storage)
        }
    }
    
    func remove(key: K) {
        self.root?.remove(key: key)
    }
    
    func find(key: K) -> V? {
        return self.root?.find(key: key)
    }
    
    func traverse(type: TraverseType, callback: (DataStorage<K, V>) -> Void) {
        self.root?.traverse(type: type, callback: callback)
    }
}


