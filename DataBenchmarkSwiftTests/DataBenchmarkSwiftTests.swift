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
        self.performTimeTest(
            prepareBlock: ArrayHelper.generateArray,
            operationBlock: { (array: [String]) -> TimeInterval in
                var array = array
                let start = CACurrentMediaTime()
                array.append(self.randomString())
                let finish = CACurrentMediaTime()
                return finish - start
        },
            structureName: "Swift3-Array", operationName: "Add")
    }
    
    func testArrayUpdate() {
        self.performTimeTest(
            prepareBlock: ArrayHelper.generateArray,
            operationBlock: { (array: [String], randomIndex: Int?, randomElement: String?) -> TimeInterval in
                var array = array
                let start = CACurrentMediaTime()
                array[randomIndex!] = self.randomString()
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Swift3-Array", operationName: "UpdateRandom")
    }
    
    func testArrayByIndexRead() {
        self.performTimeTest(
            prepareBlock: ArrayHelper.generateArray,
            operationBlock: { (array: [String], randomIndex: Int?, randomElement: String?) -> TimeInterval in
                let start = CACurrentMediaTime()
                _ = array[randomIndex!]
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Swift3-Array", operationName: "ReadRandom")
    }
    
    func testArrayByIndexDelete() {
        self.performTimeTest(
            prepareBlock: ArrayHelper.generateArray,
            operationBlock: { (array: [String], randomIndex: Int?, randomElement: String?) -> TimeInterval in
                var array = array
                let start = CACurrentMediaTime()
                array.remove(at: randomIndex!)
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Swift3-Array", operationName: "DeleteRandom")
        
    }
    
    func testArrayContains() {
        self.performTimeTest(
            prepareBlock: ArrayHelper.generateArray,
            operationBlock: { (array: [String], randomIndex: Int?, randomElement: String?) -> TimeInterval in
                let start = CACurrentMediaTime()
                _ = array.contains(randomElement!)
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: ArrayHelper.randomArrayIndex,
            randomElementBlock: ArrayHelper.randomArrayElement,
            structureName: "Swift3-Array", operationName: "ContainsRandom")
        
    }
    
    //MARK: Sets
    
    func testSetAdd() {
        self.performTimeTest(
            prepareBlock: SetHelper.generateSet,
            operationBlock: { (set: Set<String>) -> TimeInterval in
                var set = set
                let start = CACurrentMediaTime()
                set.insert(testString + String(Random.rndInt(from: 0, to: maxRandomNumber)))
                let finish = CACurrentMediaTime()
                return finish - start
        },
            structureName: "Swift3-Set", operationName: "Add")
    }
    
    func testSetDelete() {
        self.performTimeTest(
            prepareBlock: SetHelper.generateSet,
            operationBlock: { (set: Set<String>, randomIndex: Int?, randomElement: String?) -> TimeInterval in
                var set = set
                let start = CACurrentMediaTime()
                set.remove(randomElement!)
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: SetHelper.randomSetIndex,
            randomElementBlock: SetHelper.randomSetElement,
            structureName: "Swift3-Set", operationName: "DeleteRandom")
    }
    
    func testSetCheckContain() {
        self.performTimeTest(
            prepareBlock: SetHelper.generateSet,
            operationBlock: { (set: Set<String>, randomIndex: Int?, randomElement: String?) -> TimeInterval in
                let start = CACurrentMediaTime()
                _ = set.contains(randomElement!)
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: SetHelper.randomSetIndex,
            randomElementBlock: SetHelper.randomSetElement,
            structureName: "Swift3-Set", operationName: "ContainsRandom")
    }
    
    //MARK: Dictionaries
    
    func testDictionaryAdd() {
        self.performTimeTest(
            prepareBlock: DictionaryHelper.generateDictionary,
            operationBlock: { (dictionary: [String: String]) -> TimeInterval in
                var dictionary = dictionary
                let uniqueKey = testString + String(dictionary.count)
                let start = CACurrentMediaTime()
                dictionary[uniqueKey] = self.randomString()
                let finish = CACurrentMediaTime()
                return finish - start
        },
            structureName: "Swift3-Dictionary", operationName: "Add")
    }
    
    func testDictionaryUpdate() {
        self.performTimeTest(
            prepareBlock: DictionaryHelper.generateDictionary,
            operationBlock: { (dictionary: [String: String], randomIndex: String?, randomElement: String?) -> TimeInterval in
                var dictionary = dictionary
                let start = CACurrentMediaTime()
                dictionary[randomIndex!] = self.randomString()
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Swift3-Dictionary", operationName: "UpdateRandom")
    }
    
    func testDictionaryReadByKey() {
        self.performTimeTest(
            prepareBlock: DictionaryHelper.generateDictionary,
            operationBlock: { (dictionary: [String: String], randomIndex: String?, randomElement: String?) -> TimeInterval in
                let start = CACurrentMediaTime()
                _ = dictionary[randomIndex!]
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Swift3-Dictionary", operationName: "ReadRandom")
    }
    
    func testDictionaryDeleteByKey() {
        self.performTimeTest(
            prepareBlock: DictionaryHelper.generateDictionary,
            operationBlock: { (dictionary: [String: String], randomIndex: String?, randomElement: String?) -> TimeInterval in
                var dictionary = dictionary
                let start = CACurrentMediaTime()
                dictionary.removeValue(forKey: randomIndex!)
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Swift3-Dictionary", operationName: "DeleteRandom")
    }
    
    func testDictionaryCheckContain() {
        self.performTimeTest(
            prepareBlock: DictionaryHelper.generateDictionary,
            operationBlock: { (dictionary: [String: String], randomIndex: String?, randomElement: String?) -> TimeInterval in
                let start = CACurrentMediaTime()
                _ = dictionary.contains(where: { $0.0 == randomIndex && $0.1 == randomElement })
                let finish = CACurrentMediaTime()
                return finish - start
        },
            randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
            randomElementBlock: DictionaryHelper.randomDictionaryElement,
            structureName: "Swift3-Dictionary", operationName: "ContainsRandom")
    }
    
    private func randomString() -> String {
        return testString + String(Random.rndInt(from: 0, to: maxRandomNumber))
    }
    
}
