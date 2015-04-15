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
    
    /*
    This function simulates the performance of the iOS app by making
    sure the test runs on a background thread with identical priority.
    It also uses XCTestExpectation to ensure the test case waits for the
    appropriate length of time for the operation to complete.
    */
    func performFunctionInBackground(function : () -> ()) {
        let expectation = expectationWithDescription(name)
        //Use the same queue priority as in the application
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            [unowned self] in
            self.measureBlock() {
                function()
            }
            dispatch_async(dispatch_get_main_queue()) {
                //Now that we're done, fulfill the expectation.
                expectation.fulfill()
            }
        }
        
        //Set a comically long wait time, since some of these take a while,
        //especially with optimization off.
        waitForExpectationsWithTimeout(100000000.0 as NSTimeInterval, handler: { (NSError) -> Void in
        })
    }
    
    func performTimeTest<T>(prepareBlock: (Int) -> T, operationBlock: (T) -> (), structureName: String, operationName: String) {
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
    
    func performTimeTest<T, U, I>(prepareBlock: (Int) -> T, operationBlock: (T, I?, U?) -> (), randomIndexBlock: (T) -> I, randomElementBlock: (T, I) -> U, structureName: String, operationName: String) {
        var attemptsWithSumTime = [NSTimeInterval](count: maxElementsInStructure, repeatedValue: 0)
        
        for attempt in 0..<attemptsCount {
            for elementCount in 0..<maxElementsInStructure {
                var structure = prepareBlock(elementCount)
                var randomIndex: I?
                var randomElement: U?
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
        let delimiter = "," as NSString
        let writer = CHCSVWriter(outputStream: output, encoding: NSUTF8StringEncoding, delimiter: 44)
        writer.writeField("Swift")
        writer.writeField("")
        writer.finishLine()
        for elementCount in 0..<maxElementsInStructure {
            let average = attemptsWithSumTime[elementCount] / NSTimeInterval(attemptsCount)
            writer.writeField(average)
            writer.writeField(elementCount)
            writer.finishLine()
        }
        writer.closeStream()
        
        let buffer: NSData = output.propertyForKey(NSStreamDataWrittenToMemoryStreamKey) as! NSData
        let csv = NSString(data: buffer, encoding: NSUTF8StringEncoding)
        csv?.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
    }
    
    private func measureExecutionTime<T>(codeToEstimate code: (T) -> (), structure: T) -> NSTimeInterval {
        let startTime = CACurrentMediaTime()
        code(structure)
        let finishTime = CACurrentMediaTime()
        return finishTime - startTime
    }
    
    private func measureExecutionTime<T, U, I>(codeToEstimate code: (T, I?, U?) -> (), structure: T, randomIndex: I?, randomElement: U?) -> NSTimeInterval {
        let startTime = CACurrentMediaTime()
        code(structure, randomIndex, randomElement)
        let finishTime = CACurrentMediaTime()
        return finishTime - startTime
    }
}