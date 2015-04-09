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


class DataBenchmarkSwiftTests: PerformanceTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: Arrays
    
    func testArrayAdd() {
        performFunctionInBackground() {
            self.generateArray()
        }
    }
    
    func testArrayUpdate() {
        var testArray = self.generateArray()
        performFunctionInBackground() {
            for i in 0..<testArray.count {
                let randomInt = Random.rndInt(0, to: iterationCount)
                testArray[i] = testString + String(randomInt)
            }
        }
    }
    
    func testArrayFastEnumRead() {
        var testArray = self.generateArray()
        
        performFunctionInBackground() {
            for str in testArray {
                let constant = str
            }
        }
    }
    
    func testArrayByIndexRead() {
        var testArray = self.generateArray()
        
        performFunctionInBackground() {
            for var i = 0; i < testArray.count; i++ {
                let constant = testArray[i]
            }
        }
    }
    
    func testArrayByIndexDelete() {
        var testArray = self.generateArray()
        
        performFunctionInBackground() {
            for var i = 0; i < testArray.count; i++ {
                testArray.removeAtIndex(i)
            }
        }
    }
    
    func testArrayFindByIndex() {
        var testArray = self.generateArray()
        let last = testArray.last!
        performFunctionInBackground() {
            find(testArray, last)
        }
    }
    
    func testArrayCheckContain() {
        var testArray = self.generateArray()
        let last = testArray.last!
        performFunctionInBackground() {
            contains(testArray, last)
        }
    }
    
    //MARK: Sets
    
    func testSetAdd() {
        performFunctionInBackground() {
            self.generateSet()
        }
    }
    
    func testSetFastEnumRead() {
        var testSet = self.generateSet()
        
        performFunctionInBackground() {
            for str in testSet {
                let constant = str
            }
        }
    }
    
    func testSetDelete() {
        var testSet = self.generateSet()
        
        performFunctionInBackground() {
            for item in testSet {
                testSet.remove(item)
            }
        }
    }
    
    func testSetCheckContain() {
        var testSet = self.generateSet()
        let toFound = testString + String(iterationCount - 1)
        performFunctionInBackground() {
            testSet.contains(toFound)
        }
    }
    
    //MARK: Dictionaries
    
    func testDictionaryAdd() {
        performFunctionInBackground() {
            self.generateDictionary()
        }
    }
    
    func testDictionaryUpdate() {
        var testDictionary = self.generateDictionary()
        var randomDictionary = Dictionary<String, String>()
        for i in 0..<iterationCount {
            randomDictionary[String(i)] = testString + String(Random.rndInt(0, to: iterationCount))
        }
        performFunctionInBackground() {
            for key in testDictionary.keys {
                testDictionary[key] = randomDictionary[key]
            }
        }
    }
    
    func testDictionaryReadFastEnum() {
        var testDictionary = self.generateDictionary()
        
        performFunctionInBackground() {
            for value in testDictionary.values.array {
                let constant = value
            }
        }
    }
    
    func testDictionaryReadByKey() {
        var testDictionary = self.generateDictionary()
        
        performFunctionInBackground() {
            for var i = 0; i < iterationCount; i++ {
                let constant = testDictionary[String(i)]
            }
        }
    }
    
    func testDictionaryDeleteByKey() {
        var testDictionary = self.generateDictionary()
        
        performFunctionInBackground() {
            for var i = 0; i < iterationCount; i++ {
                testDictionary.removeValueForKey(String(i))
            }
        }
    }
    
    func testDictionaryCheckContain() {
        var testDictionary = self.generateDictionary()
        let toFound = testString + String(iterationCount - 1)
        performFunctionInBackground() {
            contains(testDictionary.values, toFound)
        }
    }
    
    //MARK: Helper methods
    
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
}
