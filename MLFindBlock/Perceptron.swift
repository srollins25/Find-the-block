//
//  File.swift
//  MLFindBlock
//
//  Created by stephan rollins on 12/13/18.
//  Copyright © 2018 stephan rollins. All rights reserved.
//

import Foundation
import UIKit

class Perceptron : NSObject
{
    var view: UIView?
    var x: Float?
    var y: Float?
    var lr = 0.1
    var weights = [Float]()
    
    override init() {
        var i = 0
        while(i < 2)
        {
            weights.append(Float.random(in: -1...1))
            i = i + 1
        }
    }
    
    func guess(inputs: [Float]) -> Int {
        var sum = 0.0;
        var i = 0
        while(i < weights.count)
        {
            sum = sum + Double((inputs[i] * weights[i]))
            i = i + 1
        }
        let output = sign(n: Float(sum))
        return output
    }
    
    func sign(n: Float) -> Int {
        if(n >= 0)
        {
            return 1
        }
        else
        {
            return -1
        }
    }
    
    func train(inputs: [Float], target: Int) {
        var guess = self.guess(inputs: inputs)
        var error = target - guess
        
        for i in 0 ..< weights.count
        {
            weights[i] = weights[i] + (Float(error) * inputs[i] * Float(lr))
        }
    }
    
}























