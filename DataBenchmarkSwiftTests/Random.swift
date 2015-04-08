//
//  Random.swift
//  DataBenchmarkSwift
//
//  Created by Stanislav on 08.04.15.
//  Copyright (c) 2015 Stanislav. All rights reserved.
//

import Foundation

class Random {
    
    class func rndInt(from: Int, to: Int) -> Int {
        return Int(arc4random_uniform(UInt32((to - from + 1)))) + from
    }
    
    class func rndDouble(from: Double, to: Double) -> Double {
        return drand48() * (to - from) + from;
    }
    
    class func rndBool() -> Bool {
        return Random.rndInt(0, to: 1) == 1;
    }
    
    class func willHappen(probability: Double) -> Bool {
        return Random.rndDouble(0, to: 1) <= probability
    }
    
    class func oneof<T>(array: Array<T>) -> T {
        if (array.count == 1) {
            return array[0]
        }
        let index = Random.rndInt(0, to: array.count - 1)
        return array[index]
    }
}