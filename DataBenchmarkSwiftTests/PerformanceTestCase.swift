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
    
    func performTimeTest<S>(prepareBlock: (Int) -> S, operationBlock: (S) -> (), structureName: String, operationName: String) {
        var attemptsWithSumTime = [NSTimeInterval](count: maxElementsInStructure, repeatedValue: 0)
        
        for attempt in 0..<attemptsCount {
            for elementCount in 0..<maxElementsInStructure {
                var structure = prepareBlock(elementCount)
                let time = measureExecutionTime(codeToEstimate: operationBlock, structure: structure)
                attemptsWithSumTime[elementCount] = attemptsWithSumTime[elementCount] + time
            }
        }
        
        self.writeToCSV(structureName, operationName: operationName, attemptsWithSumTime: attemptsWithSumTime)
    }
    
    func performTimeTest<S, E, I>(prepareBlock: (Int) -> S, operationBlock: (S, I?, E?) -> (), randomIndexBlock: (S) -> I, randomElementBlock: (S, I) -> E, structureName: String, operationName: String) {
        var attemptsWithSumTime = [NSTimeInterval](count: maxElementsInStructure, repeatedValue: 0)
        
        for attempt in 0..<attemptsCount {
            for elementCount in 0..<maxElementsInStructure {
                if (elementCount == 0) {
                    continue
                }
                var structure = prepareBlock(elementCount)
                var randomIndex: I?
                var randomElement: E?
                if (elementCount != 0) {
                    randomIndex = randomIndexBlock(structure)
                    randomElement = randomElementBlock(structure, randomIndex!)
                }
               
                let time = measureExecutionTime(codeToEstimate: operationBlock, structure: structure, randomIndex: randomIndex, randomElement: randomElement)
                attemptsWithSumTime[elementCount] = attemptsWithSumTime[elementCount] + time
            }
        }
        
        self.writeToCSV(structureName, operationName: operationName, attemptsWithSumTime: attemptsWithSumTime)
    }
    
    private func writeToCSV(structureName: String, operationName: String, attemptsWithSumTime: [NSTimeInterval]) {
        //write to csv
        let path = NSHomeDirectory().stringByAppendingPathComponent(structureName + "-" + operationName + ".csv")
        let fileManager = NSFileManager.defaultManager()
        fileManager.removeItemAtPath(path, error: nil)
        
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
        csv?.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
    }
    
    private func measureExecutionTime<S>(codeToEstimate code: (S) -> (), structure: S) -> NSTimeInterval {
        let startTime = CACurrentMediaTime()
        code(structure)
        let finishTime = CACurrentMediaTime()
        return finishTime - startTime
    }
    
    private func measureExecutionTime<S, E, I>(codeToEstimate code: (S, I?, E?) -> (), structure: S, randomIndex: I?, randomElement: E?) -> NSTimeInterval {
        let startTime = CACurrentMediaTime()
        code(structure, randomIndex, randomElement)
        let finishTime = CACurrentMediaTime()
        return finishTime - startTime
    }
}