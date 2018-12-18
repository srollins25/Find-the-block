//
//  Matrix.swift
//  MLFindBlock
//
//  Created by stephan rollins on 12/16/18.
//  Copyright © 2018 stephan rollins. All rights reserved.
//

import Foundation
import UIKit
import Surge


class Matrix {
    var rows: Int?
    var col: Int?
    var data = [[Double]]()
    
    init(_rows: Int, _col: Int) {
        self.rows = _rows
        self.col = _col
        self.data = [[Double]]()
        data = [[Double]](repeating: [Double](repeating: 0, count: col!), count: rows!)

    }
    
    func randomize(){
        for i in 0 ... rows! - 1
        {
            for j in 0 ... col! - 1
            {
                self.data[i][j] = Double.random(in: -1 ... 1)
            }
        }
    }
    
    func add(n: Double) {
        for i in 0 ... rows! - 1
        {
            for j in 0 ... col! - 1
            {
                self.data[i][j] += n
            }
        }
    }
    
    func add(n: Matrix) {
        for i in 0 ... rows! - 1
        {
            for j in 0 ... col! - 1
            {
                self.data[i][j] += n.data[i][j]
            }
        }
    }
    
    class func fromArray(arr: [Double]) -> Matrix
    {
        var m = Matrix(_rows: arr.count, _col: 1)
        
        for i in 0 ... arr.count -  1
        {
            m.data[i][0] = Double(arr[i])
        }
        //m.print()
        return m
    }
    
    typealias Func = (Int) -> Double
    typealias Func2 = (Int) -> Double
    
    func map(function: Func) {
        for i in 0 ... rows! - 1
        {
            for j in 0 ... col! - 1
            {
                var val = self.data[i][j]
                self.data[i][j] = function(Int(val))
            }
        }
    }
    
    class func map(m: Matrix, f: Func) -> Matrix
    {
        var m = Matrix(_rows: m.rows!, _col: m.col!)
        m.map(function: f)
        return m
    }
    
    func multiply(n: Double) {
        for i in 0 ... rows! - 1
        {
            for j in 0 ... col! - 1
            {
                self.data[i][j] *= n
            }
        }
    }
    
    class func multiply(a: Matrix, b: Matrix) -> Matrix {
        
        var result = Matrix(_rows: a.rows!, _col: b.col!)
        var sum = 0.0
        
        for i in 0 ... result.rows! - 1
        {
            for j in 0 ... result.col! - 1
            {
                sum = 0.0
                for k in 0 ... a.col! - 1
                {
                    sum += (a.data[i][k] * b.data[k][j])
                    //self.matrix[i][j] *= n.matrix[i][j]
                }
                result.data[i][j] = Double(sum)
            }
        }
        return result
    }
    
    class func subtract(a: Matrix, b: Matrix) -> Matrix {
        var result = Matrix(_rows: a.rows!, _col: a.col!)
        for i in 0 ... result.rows! - 1
        {
            for j in 0 ... result.col! - 1
            {
                result.data[i][j] = a.data[i][j] - b.data[i][j]
            }
        }
        
        return result
    }
    
    func toArray() -> [Double]
    {
        var arr = [Double]()
        
        for i in 0 ... self.rows! - 1
        {
            for j in 0 ... self.col! - 1
            {
                arr.append(self.data[i][j])
            }
        }
        return arr
    }
    
    class func transpose(matrix: Matrix, row: Int, col: Int) -> Matrix {
        let result = Matrix(_rows: col, _col: row)
        
        for i in 0 ... row - 1
        {
            for j in 0 ... col - 1
            {
                result.data[j][i] = matrix.data[i][j]
            }
        }
        return result
    }
    
    func print() {
        for i in 0 ... self.rows! - 1
        {
            Swift.print(self.data[i])
        }
    }
    
    
    
    
    
    
    
}
































