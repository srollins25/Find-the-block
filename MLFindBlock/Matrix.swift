//
//  Matrix.swift
//  MLFindBlock
//
//  Created by stephan rollins on 12/16/18.
//  Copyright © 2018 stephan rollins. All rights reserved.
//

import Foundation
import UIKit

class Matrix {
    var rows: Int?
    var col: Int?
    var data = [[Int]]()
    
    init(_rows: Int, _col: Int) {
        self.rows = _rows
        self.col = _col
        self.data = [[Int]]()
        data = [[Int]](repeating: [Int](repeating: 0, count: col!), count: rows!)
        for i in 0 ... rows! - 1
        {
            for j in 0 ... col! - 1
            {
                self.data[i][j] = 0
            }
        }
    }
    
    func randomize(){
        for i in 0 ... rows! - 1
        {
            for j in 0 ... col! - 1
            {
                self.data[i][j] = Int.random(in: 1 ... 10)
            }
        }
    }
    
    func add(n: Int) {
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
    
    func map(function: (Int) -> Int) {
        for i in 0 ... rows! - 1
        {
            for j in 0 ... col! - 1
            {
                var val = self.data[i][j]
                self.data[i][j] = function(val)
            }
        }
    }
    
    func multiply(n: Int) {
        for i in 0 ... rows! - 1
        {
            for j in 0 ... col! - 1
            {
                self.data[i][j] *= n
            }
        }
    }
    
    class func multiply(a: Matrix, b: Matrix) -> Matrix {
        //var a = self
        //var b = a
        var result = Matrix(_rows: a.rows!, _col: b.col!)
        var sum = 0
        
        for i in 0 ... result.rows! - 1
        {
            for j in 0 ... result.col! - 1
            {
                sum = 0
                for k in 0 ... a.col! - 1
                {
                    sum += (a.data[i][k] * b.data[k][j])
                    //self.matrix[i][j] *= n.matrix[i][j]
                }
                result.data[i][j] = sum
            }
        }
        return result
    }
    
    
    func transpose() -> Matrix {
        let result = Matrix(_rows: self.col!, _col: self.rows!)
        
        for i in 0 ... self.rows! - 1
        {
            for j in 0 ... self.col! - 1
            {
                result.data[j][i] = self.data[i][j]
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
































