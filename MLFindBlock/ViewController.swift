//
//  ViewController.swift
//  MLFindBlock
//
//  Created by stephan rollins on 12/12/18.
//  Copyright © 2018 stephan rollins. All rights reserved.
//

import UIKit

struct Traingdata {
    var inputs: [Double]
    var targets: [Double]
}

class ViewController: UIViewController {


    var score = 0
    var genCount = 0
    var numOfBlocks = 100
    var traingData: [Traingdata] = []
    
    var arr = [1, 0, -5]
    var nn = NeuralNetwork(inputs: 2, hidden: 2, outputs: 1)
    var input = [1.0, 0.0]
    var target = [1.0]
    
    var blocks = [Block]()
    let finishBlock = UIView()

    var inputs: Array<Float> = [-1,0.5]
    let point = CGPoint(x:Int(arc4random()%UInt32(UIScreen.main.bounds.width)),y:Int(arc4random()%UInt32(UIScreen.main.bounds.height)))
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.cyan.cgColor
        button.setTitle("Randomize", for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.setTitleColor(UIColor.cyan, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(plotBlocks), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.cyan.cgColor
        button.setTitle("Move", for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.setTitleColor(UIColor.cyan, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.addTarget(self, action: #selector(move), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: "
        label.font = label.font.withSize(22)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genLabel: UILabel = {
        let label = UILabel()
        label.text = "Generation: "
        label.font = label.font.withSize(22)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(scoreLabel)
        view.addSubview(genLabel)
        
        traingData.append(Traingdata(inputs: [0, 1], targets: [1]))
        traingData.append(Traingdata(inputs: [1, 0], targets: [1]))
        traingData.append(Traingdata(inputs: [0, 0], targets: [0]))
        traingData.append(Traingdata(inputs: [1, 1], targets: [0]))
        
        // Do any additional setup after loading the view, typically from a nib.
        finishBlock.frame.size.width = 30
        finishBlock.frame.size.height = 30
        finishBlock.backgroundColor = UIColor.green
        finishBlock.center.x = 200
        finishBlock.center.y = 200
        plotBlocks()

        for i in 0 ... 10000
        {
            for data in traingData
            {
            nn.train(inputs: data.inputs, targetarray: data.targets)
            }
        }
        
        print(nn.feedforward(input_array: [1, 0]))
        print(nn.feedforward(input_array: [0, 1]))
        print(nn.feedforward(input_array: [1, 1]))
        print(nn.feedforward(input_array: [0, 0]))
        
    }
    
    func doubleIt(x: Int) -> Int
    {
        return x * 2
    }
    
    @objc func plotBlocks()
    {
        removeBlocks()
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 360).isActive = true
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 260).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -150).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -370).isActive = true
        genLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -125).isActive = true
        genLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -340).isActive = true
        genCount = genCount + 1
        
        for i in 0 ..< numOfBlocks
        {
            if(blocks.count != numOfBlocks)
            {
                blocks.append(Block())
                print("Block:", i, blocks[i].block?.center.x, blocks[i].block?.center.y)

            }
            if(i % 2 == 0)
            {
                blocks[i].block?.backgroundColor = UIColor.blue
            }
            
            else
            {
                blocks[i].block?.backgroundColor = UIColor.orange
            }
            blocks[i].block?.frame.size.width = 25
            blocks[i].block?.frame.size.height = 25
            view.addSubview(blocks[i].block!)
            scoreLabel.text = "Score: "
            genLabel.text = "\("Generation:") \(genCount)"
        }
        self.view.addSubview(finishBlock)
    }
    
    func removeBlocks(){
        if(blocks.count != 0)
        {

            for i in stride(from: blocks.count - 1, to: 0, by: -1)
            {
                blocks[i].block?.isHidden = true
            }

        }
        blocks.removeAll()
    }
    
    @objc func move()
    {
        for view in blocks
        {
            var inputs = [Float((view.block?.center.x)!), Float((view.block?.center.y)!)]
            var target = view.label
            //brain.train(inputs: inputs, target: view.label!)
            
            //var guess = brain.guess(inputs: inputs)

            
            if(((view.block?.center.x)! > UIScreen.main.bounds.width || (view.block?.center.x)! < CGFloat(0.0)) || ((view.block?.center.y)! > UIScreen.main.bounds.height || (view.block?.center.y)! < CGFloat(0.0)))
            {
                if let index = blocks.index(where: {$0 === view})
                {
                    blocks.remove(at: index)
                    view.block!.isHidden = true
                    print("removed view!!")
                    print(scoreLabel.text!)
                }
            }
                
            else if(view.block!.frame.intersects(finishBlock.frame))
            {
                if let index2 = blocks.index(where: {$0 === view})
                {
                    blocks.remove(at: index2)
                    view.block!.isHidden = true
                    score += 1
                    print("made it home!!")
                    print(scoreLabel.text!)
                }
            }
                
            else
            {
                let duration: Double = 1.0
                UIView.animate(withDuration: duration)
                {
                    view.block!.center.x += CGFloat.random(in: -20...20)
                    view.block!.center.y += CGFloat.random(in: -20...20)
                }
                //print("x:", view.block!.center.x, "y:", view.block!.center.y)
            }
        }
        print("")
        print("")

    }
}

































