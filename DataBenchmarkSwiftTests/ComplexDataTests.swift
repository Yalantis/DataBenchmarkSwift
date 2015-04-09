//
//  ComplexDataTests.swift
//  DataBenchmarkSwift
//
//  Created by Stas Kirichok on 10.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import UIKit
import XCTest

private let iterationCount = 10000

class ComplexDataTests: PerformanceTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Linked lists
    
    // TODO Linked list crashes while dealloc if number of iterations is bigger than 10000
    func testLinkedListWriteSpeed() {
        performFunctionInBackground() {
            self.generateLinkedList()
        }
    }
    
    func testLinkedListFastEnumReadSpeed() {
        var testLinkedList = self.generateLinkedList()
        
        performFunctionInBackground() {
            for str in testLinkedList {
                let constant = str
            }
        }
    }
    
    func testLinkedListFastEnumDeleteSpeed() {
        var testLinkedList = self.generateLinkedList()
        
        performFunctionInBackground() {
            for item in testLinkedList {
                testLinkedList.removeFirstOccurenceOf(item)
            }
        }
    }
    
    //MARK: Stacks
    func testStackWriteSpeed() {
        var testStack = Stack<String>()
        performFunctionInBackground() {
            [unowned testStack] in
            for var i = 0; i < iterationCount; i++ {
                testStack.push(testString + String(i))
            }
        }
    }
    
    func testStackReadSpeed() {
        let testStack = self.generateStack()
        
        performFunctionInBackground() {
            for _ in 0..<iterationCount {
                let constant = testStack.pop()
            }
        }
    }
    
    //MARK: Queues
    
    func testQueueWriteSpeed() {
        performFunctionInBackground() {
            self.generateQueue()
        }
    }
    
    func testQueueReadSpeed() {
        let testQueue = self.generateQueue()
        
        performFunctionInBackground() {
            for _ in 0..<iterationCount {
                let constant = testQueue.dequeue()
            }
        }
    }
    
    //MARK: Helper methods
    
    func generateLinkedList() -> OptimizedLinkedList<String> {
        var testLinkedList = OptimizedLinkedList<String>()
        for var i = 0; i < iterationCount; i++ {
            testLinkedList.add(testString + String(i))
        }
        
        return testLinkedList
    }
    
    func generateStack() -> Stack<String> {
        var testStack = Stack<String>()
        for var i = 0; i < iterationCount; i++ {
            testStack.push(testString + String(i))
        }
        
        return testStack
    }
    
    func generateQueue() -> Queue<String> {
        var testQueue = Queue<String>()
        for var i = 0; i < iterationCount; i++ {
            testQueue.add(testString + String(i))
        }
        
        return testQueue
    }
    
}
