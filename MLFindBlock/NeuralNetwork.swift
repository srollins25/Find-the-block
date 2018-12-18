//
//  File.swift
//  MLFindBlock
//
//  Created by stephan rollins on 12/13/18.
//  Copyright © 2018 stephan rollins. All rights reserved.
//

import Foundation
import UIKit

func sigmoid(x: Int) -> Double
{
    //print("Output: ", (1 / (1 + exp(Double(-x)))))
    return 1 / (1 + exp(Double(x)))
}

func dsigmoid(y: Int) -> Double {
    return Double(y * (1 - y))
}

class NeuralNetwork
{
    var numOfInputs: Int?
    var numOfHidden: Int?
    var numOfOutputs: Int?
    var weightsih: Matrix?
    var weightsho: Matrix?
    var biasH: Matrix?
    var biasO: Matrix?
    var learningrate: Double?
    
    init(inputs: Int, hidden: Int, outputs: Int) {
        self.numOfInputs = inputs
        self.numOfHidden = hidden
        self.numOfOutputs = outputs
        self.weightsih = Matrix(_rows: self.numOfHidden!, _col: self.numOfInputs!)
        self.weightsho = Matrix(_rows: self.numOfOutputs!, _col: self.numOfHidden!)
        self.weightsih?.randomize()
        self.weightsho?.randomize()
        self.biasH = Matrix(_rows: self.numOfHidden!, _col: 1)
        self.biasO = Matrix(_rows: self.numOfOutputs!, _col: 1)
        self.biasH?.randomize()
        self.biasO?.randomize()
        self.learningrate = 0.1
    }
    
    func feedforward(input_array: [Double]) -> [Double] {
        
        var inputs = Matrix.fromArray(arr: input_array)
        var hidden = Matrix.multiply(a: self.weightsih!, b: inputs)
        hidden.add(n: self.biasH!)
        hidden.map(function: sigmoid)

        var output = Matrix.multiply(a: self.weightsho!, b: hidden)
        output.add(n: self.biasO!)
        output.map(function: sigmoid)
        
        return output.toArray()
    }
    
    func train(inputs: [Double], targetarray: [Double])
    {
        var inputs2 = Matrix.fromArray(arr: inputs)
        var hidden = Matrix.multiply(a: self.weightsih!, b: inputs2)
        hidden.add(n: self.biasH!)
        hidden.map(function: sigmoid)

        var outputs = Matrix.multiply(a: self.weightsho!, b: hidden)
        outputs.add(n: self.biasO!)
        outputs.map(function: sigmoid)
        
        var outputs1 = self.feedforward(input_array: inputs)
        var outputs2 = Matrix.fromArray(arr: outputs1)
        
        var targets = Matrix.fromArray(arr: targetarray)
        var outputerrors = Matrix.subtract(a: outputs2, b: targets)
        
        //var gradient = outputs * (1 - outputs)
        var gradient = Matrix.map(m: outputs, f: dsigmoid)
        gradient = Matrix.multiply(a: outputs, b: outputerrors)
        gradient.multiply(n: learningrate!)
        
        
        
        var hiddenT = Matrix.transpose(matrix: hidden, row: hidden.rows!, col: hidden.col!)
        var weighthodeltas = Matrix.multiply(a: gradient, b: hiddenT)
        
        self.weightsho?.add(n: weighthodeltas)
        self.biasO?.add(n: gradient)
        
        var whot = Matrix.transpose(matrix: self.weightsho!, row: self.weightsho!.rows!, col: self.weightsho!.col!)
        var hiddenerrors = Matrix.multiply(a: whot, b: outputerrors)
        
        var hiddengraient = Matrix.map(m: hidden, f: dsigmoid)
        hiddengraient = Matrix.multiply(a: hiddengraient, b: hiddenerrors)
        hiddengraient.multiply(n: self.learningrate!)
        
        var inputsT = Matrix.transpose(matrix: inputs2, row: inputs2.rows!, col: inputs2.col!)
        var weightihdeltas = Matrix.multiply(a: hiddengraient, b: inputsT)
        self.weightsih?.add(n: weightihdeltas)
        self.biasH?.add(n: hiddengraient)
        
        
        
        print("-----------------------------------")
        print("outputs: ", outputs2.data)
//        outputs2.print()
        print("targets: ", targets.data)
//        targets2.print()
        print("Error: ", outputerrors.data)
//        outputerrors.print()
    }
    
}























