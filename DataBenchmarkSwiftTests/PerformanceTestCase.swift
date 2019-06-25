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
    
    func performTimeTest<S>(prepareBlock: (Int) -> S, operationBlock: (S) -> TimeInterval, structureName: String, operationName: String) {
        var attemptsWithSumTime = [TimeInterval](repeating: 0, count: maxElementsInStructure)
        
        for _ in 0..<attemptsCount {
            for elementCount in 0..<maxElementsInStructure {
                let structure = prepareBlock(elementCount)
                let time = operationBlock(structure)
                attemptsWithSumTime[elementCount] = attemptsWithSumTime[elementCount] + time
            }
        }
        
        self.writeToCSV(structureName: structureName, operationName: operationName, attemptsWithSumTime: attemptsWithSumTime)
    }
    
    func performTimeTest<S, E, I>(prepareBlock: (Int) -> S, operationBlock: (S, I?, E?) -> TimeInterval, randomIndexBlock: (S) -> I, randomElementBlock: (S, I) -> E, structureName: String, operationName: String) {
        var attemptsWithSumTime = [TimeInterval](repeating: 0, count: maxElementsInStructure)
        
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
        
        self.writeToCSV(structureName: structureName, operationName: operationName, attemptsWithSumTime: attemptsWithSumTime)
    }
    
    private func writeToCSV(structureName: String, operationName: String, attemptsWithSumTime: [TimeInterval]) {
        //write to csv
        do {
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true
            )
            let path = documentDirectory.appendingPathComponent(structureName + "-" + operationName + ".csv")
            try? FileManager.default.removeItem(atPath: path.absoluteString)
            
            let output = OutputStream.toMemory()
            let delimiter: unichar = 44 // comma unichar
            let writer = CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: delimiter)
            //        writer?.writeField("")
            writer?.writeField("Swift")
            writer?.finishLine()
            for elementCount in 0..<maxElementsInStructure {
                let average = attemptsWithSumTime[elementCount] / TimeInterval(attemptsCount)
                writer?.writeField(elementCount)
                writer?.writeField(average)
                writer?.finishLine()
            }
            writer?.closeStream()
            let buffer: Data = output.property(forKey: Stream.PropertyKey.dataWrittenToMemoryStreamKey) as! Data
            let csv = String(data: buffer, encoding: String.Encoding.utf8)
            try csv?.write(to: path, atomically: false, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
}
