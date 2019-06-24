//
//  Helpers.swift
//  DataBenchmarkSwift
//
//  Created by Stanislav on 15.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import Foundation

class ArrayHelper {
    class func generateArray(elementCount: Int) -> [String] {
        var testArray = [String]()
        for i in 0..<elementCount {
            testArray.append(testString + String(i))
        }
        
        return testArray
    }
    
    class func randomArrayIndex(array: [String]) -> Int {
        return Random.rndInt(from: 0, to: array.count - 1)
    }
    
    class func randomArrayElement(array: [String], randomIndex: Int) -> String {
        return array[randomIndex]
    }
}

class SetHelper {
    class func generateSet(elementCount: Int) -> Set<String> {
        var testSet = Set<String>()
        for i in 0..<elementCount {
            testSet.insert(testString + String(i))
        }
        
        return testSet
    }
    
    class func randomSetIndex(set: Set<String>) -> Int {
        return Random.rndInt(from: 0, to: set.count - 1)
    }
    
    class func randomSetElement(set: Set<String>, randomIndex: Int) -> String {
        return testString + String(randomIndex)
    }
}

class DictionaryHelper {
    class func generateDictionary(elementCount: Int) -> [String: String] {
        var testDictionary = [String: String]()
        for i in 0..<elementCount {
            testDictionary[String(i)] = testString + String(i)
        }
        
        return testDictionary
    }
    
    class func randomDictionaryIndex(dict: [String: String]) -> String {
        return String(Random.rndInt(from: 0, to: dict.count - 1))
    }
    
    class func randomDictionaryElement(dict: [String: String], randomIndex: String) -> String {
        return dict[randomIndex]!
    }
}
