//
//  DataBenchmarkSwiftTests.swift
//  DataBenchmarkSwiftTests
//
//  Created by Stanislav on 01.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import UIKit
import XCTest

private let maxRandomNumber = 100000

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
        self.performTimeTest(ArrayHelper.generateArray,
            operationBlock: {(var array: [String]) -> () in
                array.append(testString + String(Random.rndInt(0, to: maxRandomNumber)))
            },
            structureName: "Array", operationName: "Add")
    }
    
    func testArrayUpdate() {
        self.performTimeTest(ArrayHelper.generateArray,
            operationBlock: {(var array: [String], randomIndex: Int?, randomElement: String?) -> () in
                array[randomIndex!] = testString + String(Random.rndInt(0, to: maxRandomNumber))
            },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Array", operationName: "UpdateRandom")
    }
    
    func testArrayByIndexRead() {
        self.performTimeTest(ArrayHelper.generateArray,
            operationBlock: {(var array: [String], randomIndex: Int?, randomElement: String?) -> () in
                let constant = array[randomIndex!]
            },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Array", operationName: "ReadRandom")
    }
    
    func testArrayByIndexDelete() {
        self.performTimeTest(ArrayHelper.generateArray,
            operationBlock: {(var array: [String], randomIndex: Int?, randomElement: String?) -> () in
                array.removeAtIndex(randomIndex!)
            },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Array", operationName: "DeleteRandom")
        
    }
    
    func testArrayContains() {
        self.performTimeTest(ArrayHelper.generateArray,
            operationBlock: {(var array: [String], randomIndex: Int?, randomElement: String?) -> () in
                let constant = contains(array, randomElement!)
            },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Array", operationName: "ContainsRandom")
        
    }
    
    //MARK: Sets
    
    func testSetAdd() {
        self.performTimeTest(SetHelper.generateSet,
            operationBlock: { (var set: Set<String>) -> () in
                set.insert(testString + String(Random.rndInt(0, to: maxRandomNumber)))
            },
            structureName: "Set", operationName: "Add")
    }
    
    func testSetDelete() {
        self.performTimeTest(SetHelper.generateSet,
            operationBlock: {(var set: Set<String>, randomIndex: Int?, randomElement: String?) -> () in
                set.remove(randomElement!)
            },
            randomIndexBlock: SetHelper.randomSetIndex,
            randomElementBlock: SetHelper.randomSetElement,
            structureName: "Set", operationName: "DeleteRandom")
    }
    
    func testSetCheckContain() {
        self.performTimeTest(SetHelper.generateSet,
            operationBlock: {(var set: Set<String>, randomIndex: Int?, randomElement: String?) -> () in
                let constant = contains(set, randomElement!)
            },
            randomIndexBlock: SetHelper.randomSetIndex,
            randomElementBlock: SetHelper.randomSetElement,
            structureName: "Set", operationName: "ContainsRandom")
    }
    
    //MARK: Dictionaries
    
    func testDictionaryAdd() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: { (var dict: [String: String]) -> () in
                let uniqueKey = testString + String(dict.count)
                dict[uniqueKey] = (testString + String(Random.rndInt(0, to: maxRandomNumber)))
            },
            structureName: "Dictionary", operationName: "Add")
    }
    
    func testDictionaryUpdate() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: { (var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> () in
                dictionary[randomIndex!] = (testString + String(Random.rndInt(0, to: maxRandomNumber)))
            },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Dictionary", operationName: "UpdateRandom")
    }
    
    func testDictionaryReadByKey() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: {(var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> () in
                let constant = dictionary[randomIndex!]
            },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Dictionary", operationName: "ReadRandom")
    }
    
    func testDictionaryDeleteByKey() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: {(var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> () in
                dictionary.removeValueForKey(randomIndex!)
            },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Dictionary", operationName: "DeleteRandom")
    }
    
    func testDictionaryCheckContain() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: {(var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> () in
                contains(dictionary.values, randomElement!)
            },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Dictionary", operationName: "ContainsRandom")
    }
    
}
