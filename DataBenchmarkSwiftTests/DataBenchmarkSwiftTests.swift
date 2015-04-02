//
//  DataBenchmarkSwiftTests.swift
//  DataBenchmarkSwiftTests
//
//  Created by Stanislav on 01.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import UIKit
import XCTest

private let iterationCount = 100000
private let testString = "test"

class DataBenchmarkSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: Arrays
    
    func testArrayWriteSpeed() {
        self.measureBlock() {
           self.generateArray()
        }
    }
    
    func testArrayFastEnumReadSpeed() {
        var testArray = self.generateArray()
        
        self.measureBlock() {
            for str in testArray {
                let constant = str
            }
        }
    }
    
    func testArrayByIndexReadSpeed() {
            var testArray = self.generateArray()
        
        self.measureBlock() {
            for var i = 0; i < testArray.count; i++ {
                let constant = testArray[i]
            }
        }
    }
    
    func testArrayByIndexDeleteSpeed() {
        var testArray = self.generateArray()
        
        self.measureBlock() {
            for var i = 0; i < testArray.count; i++ {
               testArray.removeAtIndex(i)
            }
        }
    }
    
    func testArrayFindSpeed() {
        var testArray = self.generateArray()
        let last = testArray.last!
        self.measureBlock() {
            find(testArray, last)
        }
    }
    
    //MARK: Sets
    
    func testSetWriteSpeed() {
        self.measureBlock() {
           self.generateSet()
        }
    }
    
    func testSetFastEnumReadSpeed() {
        var testSet = self.generateSet()
        
        self.measureBlock() {
            for str in testSet {
                let constant = str
            }
        }
    }
    
    func testSetFastEnumDeleteSpeed() {
        var testSet = self.generateSet()
        
        self.measureBlock() {
            for item in testSet {
                testSet.remove(item)
            }
        }
    }
    
    func testSetFindSpeed() {
        var testSet = self.generateSet()
        let toFound = testString + String(iterationCount - 1)
        self.measureBlock() {
            testSet.indexOf(toFound)
        }
    }
    
    //MARK: Dictionaries
    
    func testDictionaryWriteSpeed() {
        self.measureBlock() {
            self.generateDictionary()
        }
    }
    
    func testDictionaryFastEnumReadSpeed() {
        var testDictionary = self.generateDictionary()
        
        self.measureBlock() {
            for value in testDictionary.values.array {
                let constant = value
            }
        }
    }
    
    func testDictionaryByKeyReadSpeed() {
        var testDictionary = self.generateDictionary()
        
        self.measureBlock() {
            for var i = 0; i < iterationCount; i++ {
                let constant = testDictionary[String(i)]
            }
        }
    }
    
    func testDictionaryByKeyDeleteSpeed() {
        var testDictionary = self.generateDictionary()
        
        self.measureBlock() {
            for var i = 0; i < iterationCount; i++ {
                testDictionary.removeValueForKey(String(i))
            }
        }
    }
    
    func testDictionaryFindSpeed() {
        var testDictionary = self.generateDictionary()
        let toFound = testString + String(iterationCount - 1)
        self.measureBlock() {
            find(testDictionary.values, toFound)
        }
    }
    
    //Linked lists
    
    func testLinkedListWriteSpeed() {
        self.measureBlock() {
            self.generateLinkedList()
        }
    }
    
    func testLinkedListFastEnumReadSpeed() {
        var testLinkedList = self.generateLinkedList()
        
        self.measureBlock() {
            for str in testLinkedList {
                let constant = str
            }
        }
    }
    
    func testLinkedListFastEnumDeleteSpeed() {
        var testLinkedList = self.generateLinkedList()
        
        self.measureBlock() {
            for item in testLinkedList {
                testLinkedList.removeFirstOccurenceOf(item)
            }
        }
    }

    func generateArray() -> [String] {
        var testArray = [String]()
        for var i = 0; i < iterationCount; i++ {
            testArray.append(testString + String(i))
        }
        
        return testArray
    }
    
    func generateSet() -> Set<String> {
        var testSet = Set<String>()
        for var i = 0; i < iterationCount; i++ {
            testSet.insert(testString + String(i))
        }
        
        return testSet
    }
    
    func generateDictionary() -> [String: String] {
        var testDictionary = [String: String]()
        for var i = 0; i < iterationCount; i++ {
            testDictionary[String(i)] = testString + String(i)
        }
        
        return testDictionary
    }
    
    func generateLinkedList() -> LinkedList<String> {
        var testLinkedList = LinkedList<String>()
        for var i = 0; i < iterationCount; i++ {
            testLinkedList.add(testString + String(i))
        }
        
        return testLinkedList
    }

    
}
