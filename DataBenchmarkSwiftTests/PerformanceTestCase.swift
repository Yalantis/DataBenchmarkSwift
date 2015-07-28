//
//  XCTestExtension.swift
//  DataStructures
//
//  Created by Ellen Shapiro on 8/4/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

import Foundation
import XCTest
import QuartzCore

let testString = "test"
let attemptsCount = 10
let maxElementsInStructure = 500

class PerformanceTestCase : XCTestCase {
    
    func performTimeTest<S>(prepareBlock: (Int) -> S, operationBlock: (S) -> NSTimeInterval, structureName: String, operationName: String) {
        var attemptsWithSumTime = [NSTimeInterval](count: maxElementsInStructure, repeatedValue: 0)
        
        for _ in 0..<attemptsCount {
            for elementCount in 0..<maxElementsInStructure {
                let structure = prepareBlock(elementCount)
                let time = operationBlock(structure)
                attemptsWithSumTime[elementCount] = attemptsWithSumTime[elementCount] + time
            }
        }
        
        self.writeToCSV(structureName, operationName: operationName, attemptsWithSumTime: attemptsWithSumTime)
    }
    
    func performTimeTest<S, E, I>(prepareBlock: (Int) -> S, operationBlock: (S, I?, E?) -> NSTimeInterval, randomIndexBlock: (S) -> I, randomElementBlock: (S, I) -> E, structureName: String, operationName: String) {
        var attemptsWithSumTime = [NSTimeInterval](count: maxElementsInStructure, repeatedValue: 0)
        
        for _ in 0..<attemptsCount {
            for elementCount in 0..<maxElementsInStructure {
                if (elementCount == 0) {
                    continue
                }
                let structure = prepareBlock(elementCount)
                var randomIndex: I?
                var randomElement: E?
                if (elementCount != 0) {
                    randomIndex = randomIndexBlock(structure)
                    randomElement = randomElementBlock(structure, randomIndex!)
                }
               
                let time = operationBlock(structure, randomIndex, randomElement)
                attemptsWithSumTime[elementCount] = attemptsWithSumTime[elementCount] + time
            }
        }
        
        self.writeToCSV(structureName, operationName: operationName, attemptsWithSumTime: attemptsWithSumTime)
    }
    
    private func writeToCSV(structureName: String, operationName: String, attemptsWithSumTime: [NSTimeInterval]) {
        //write to csv
        let path = NSHomeDirectory().stringByAppendingPathComponent(structureName + "-" + operationName + ".csv")
        let fileManager = NSFileManager.defaultManager()
        try! fileManager.removeItemAtPath(path)
        
        let output = NSOutputStream.outputStreamToMemory()
        let delimiter: unichar = 44 // comma unichar
        let writer = CHCSVWriter(outputStream: output, encoding: NSUTF8StringEncoding, delimiter: delimiter)
        writer.writeField("")
        writer.writeField("Swift")
        writer.finishLine()
        for elementCount in 0..<maxElementsInStructure {
            let average = attemptsWithSumTime[elementCount] / NSTimeInterval(attemptsCount)
            writer.writeField(elementCount)
            writer.writeField(average)
            writer.finishLine()
        }
        writer.closeStream()
        
        let buffer: NSData = output.propertyForKey(NSStreamDataWrittenToMemoryStreamKey) as! NSData
        let csv = NSString(data: buffer, encoding: NSUTF8StringEncoding)
        try! csv?.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
    }
}