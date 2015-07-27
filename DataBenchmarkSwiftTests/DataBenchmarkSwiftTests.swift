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
            operationBlock: {(var array: [String]) -> NSTimeInterval in
                 let start = CACurrentMediaTime()
                array.append(self.randomString())
                 let finish = CACurrentMediaTime()
                return finish - start
            },
            structureName: "Array", operationName: "Add")
    }
    
    func testArrayUpdate() {
        self.performTimeTest(ArrayHelper.generateArray,
            operationBlock: {(var array: [String], randomIndex: Int?, randomElement: String?) -> NSTimeInterval in
                 let start = CACurrentMediaTime()
                array[randomIndex!] = self.randomString()
                 let finish = CACurrentMediaTime()
                 return finish - start
            },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Array", operationName: "UpdateRandom")
    }
    
    func testArrayByIndexRead() {
        self.performTimeTest(ArrayHelper.generateArray,
            operationBlock: {(var array: [String], randomIndex: Int?, randomElement: String?) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                let constant = array[randomIndex!]
                let finish = CACurrentMediaTime()
                return finish - start
            },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Array", operationName: "ReadRandom")
    }
    
    func testArrayByIndexDelete() {
        self.performTimeTest(ArrayHelper.generateArray,
            operationBlock: {(var array: [String], randomIndex: Int?, randomElement: String?) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                array.removeAtIndex(randomIndex!)
                let finish = CACurrentMediaTime()
                return finish - start
            },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Array", operationName: "DeleteRandom")
        
    }
    
    func testArrayContains() {
        self.performTimeTest(ArrayHelper.generateArray,
            operationBlock: {(var array: [String], randomIndex: Int?, randomElement: String?) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                let constant = array.contains(randomElement!)
                let finish = CACurrentMediaTime()
                return finish - start
            },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Array", operationName: "ContainsRandom")
        
    }
    
    //MARK: Sets
    
    func testSetAdd() {
        self.performTimeTest(SetHelper.generateSet,
            operationBlock: { (var set: Set<String>) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                set.insert(testString + String(Random.rndInt(0, to: maxRandomNumber)))
                let finish = CACurrentMediaTime()
                return finish - start
            },
            structureName: "Set", operationName: "Add")
    }
    
    func testSetDelete() {
        self.performTimeTest(SetHelper.generateSet,
            operationBlock: {(var set: Set<String>, randomIndex: Int?, randomElement: String?) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                set.remove(randomElement!)
                let finish = CACurrentMediaTime()
                return finish - start
            },
            randomIndexBlock: SetHelper.randomSetIndex,
            randomElementBlock: SetHelper.randomSetElement,
            structureName: "Set", operationName: "DeleteRandom")
    }
    
    func testSetCheckContain() {
        self.performTimeTest(SetHelper.generateSet,
            operationBlock: {(var set: Set<String>, randomIndex: Int?, randomElement: String?) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                let constant = set.contains(randomElement!)
                let finish = CACurrentMediaTime()
                return finish - start
            },
            randomIndexBlock: SetHelper.randomSetIndex,
            randomElementBlock: SetHelper.randomSetElement,
            structureName: "Set", operationName: "ContainsRandom")
    }
    
    //MARK: Dictionaries
    
    func testDictionaryAdd() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: { (var dict: [String: String]) -> NSTimeInterval in
                let uniqueKey = testString + String(dict.count)
                  let start = CACurrentMediaTime()
                dict[uniqueKey] = self.randomString()
                let finish = CACurrentMediaTime()
                return finish - start
            },
            structureName: "Dictionary", operationName: "Add")
    }
    
    func testDictionaryUpdate() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: { (var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                dictionary[randomIndex!] = self.randomString()
                let finish = CACurrentMediaTime()
                return finish - start
            },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Dictionary", operationName: "UpdateRandom")
    }
    
    func testDictionaryReadByKey() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: {(var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                let constant = dictionary[randomIndex!]
                let finish = CACurrentMediaTime()
                return finish - start
            },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Dictionary", operationName: "ReadRandom")
    }
    
    func testDictionaryDeleteByKey() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: {(var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                dictionary.removeValueForKey(randomIndex!)
                let finish = CACurrentMediaTime()
                return finish - start
            },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Dictionary", operationName: "DeleteRandom")
    }
    
    func testDictionaryCheckContain() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
            operationBlock: {(var dictionary: [String: String], randomIndex: String?, randomElement: String?) -> NSTimeInterval in
                  let start = CACurrentMediaTime()
                dictionary.values.contains(randomElement!)
                let finish = CACurrentMediaTime()
                return finish - start
            },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Dictionary", operationName: "ContainsRandom")
    }
    
    private func randomString() -> String {
        return testString + String(Random.rndInt(0, to: maxRandomNumber))
    }
    
}
