//
//  XCTestExtension.swift
//  DataStructures
//
//  Created by Ellen Shapiro on 8/4/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

import Foundation
import XCTest

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
             println("finish tests")
     })
    }
}