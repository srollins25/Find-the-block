//
//  Block.swift
//  MLFindBlock
//
//  Created by stephan rollins on 12/14/18.
//  Copyright © 2018 stephan rollins. All rights reserved.
//

import Foundation
import UIKit

class Block {
    var block: UIView?
    var label: Int?
    //var x: Float?
    //var y: Float?
    
    init() {
        self.block = UIView()
        self.block?.center.x = CGFloat(Float.random(in: 0 ..< Float(UIScreen.main.bounds.width)))
        //print("printing from block: ", x)
        self.block?.center.y = CGFloat(Float.random(in: 0 ..< Float(UIScreen.main.bounds.height)))
        //print("printing from block: ", y)
        self.Point()
        print("label: ", self.label)
    }
    
    func Point(){
        if(((self.block?.center.x.isLess(than: (self.block?.center.y)!))!))
        {
            label = 1
        }
        
        else
        {
            label = -1
        }
    }
}




















