//
//  Node.swift
//  DataBenchmarkSwift
//
//  Created by Stanislav on 01.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import Foundation

class LinkedNode<T> {
    var storedValue: T?
    var link: LinkedNode?
    
    init(value: T, nextLinkedNode node: LinkedNode) {
        self.storedValue = value
        self.link = node
    }
    
    init(value: T) {
        self.storedValue = value
    }

}