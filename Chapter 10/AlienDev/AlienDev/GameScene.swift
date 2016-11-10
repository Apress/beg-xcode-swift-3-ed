//
//  GameScene.swift
//  AlienDev
//
//  Created by Matthew Knott on 03/11/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var alienDev : SKSpriteNode?
    var lastSpawnTimeInterval : CFTimeInterval?
    var lastUpdateTimeInterval : CFTimeInterval?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = SKColor.whiteColor()
        alienDev = SKSpriteNode(imageNamed: "dev")
        alienDev!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        alienDev?.size = CGSizeMake(120, 220)
        
        self.addChild(alienDev!)

        let title = createTextNode("Welcome to Alien Dev",
            nodeName: "titleNode",
            position: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-150))
        self.addChild(title)
    }
    
    func createTextNode(text: String, nodeName: String, position: CGPoint) -> SKLabelNode {
        let labelNode = SKLabelNode(fontNamed: "Futura")
        labelNode.name = nodeName
        labelNode.text = text
        labelNode.fontSize = 30
        labelNode.fontColor = SKColor.blackColor()
        labelNode.position = position
        return labelNode
    }
    
    func createBug() {
        let evilBug = SKSpriteNode(imageNamed: "bug")
        evilBug.size = CGSizeMake(220, 120)
        
        
        let minX = (evilBug.size.width / 2)
        let maxX = (self.frame.size.width - evilBug.size.width)
        let rangeX : UInt32 = UInt32(maxX - minX)
        
        let finalX = Int(arc4random() % rangeX) + Int(minX)
        
        evilBug.position = CGPointMake(CGFloat(finalX), self.frame.size.height + evilBug.size.height/2)
        self.addChild(evilBug)
        
        let minDuration : Int = 3
        let maxDuration : Int = 8
        let rangeDuration : UInt32 = UInt32(maxDuration - minDuration)
        
        let finalDuration = Int(arc4random() % rangeDuration) + minDuration
        
        let actionMove = SKAction.moveTo(CGPointMake(CGFloat(finalX), -evilBug.size.height/2), duration:NSTimeInterval(finalDuration))
        let actionMoveDone = SKAction.removeFromParent()
        
        evilBug.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
   
    func updateWithTimeSinceLastUpdate(timeSinceLast : CFTimeInterval) {
        if let lastSpawn = lastSpawnTimeInterval {
            lastSpawnTimeInterval! += timeSinceLast
            if (lastSpawnTimeInterval > 1 ) {
                lastSpawnTimeInterval = 0
                createBug()
            }
        }
        else
        {
            lastSpawnTimeInterval = 0
        }
    }

    override func update(currentTime: CFTimeInterval) {
        
        if let lastUpdate = lastUpdateTimeInterval {
            
            var timeSinceLast = currentTime - lastUpdate as CFTimeInterval
            
            lastUpdateTimeInterval = currentTime
            if (timeSinceLast > 1) {
                timeSinceLast = 1.0 / 60.0
                lastUpdateTimeInterval = currentTime
            }
            
            updateWithTimeSinceLastUpdate(timeSinceLast)
        }
        else
        {
            lastUpdateTimeInterval = currentTime
        }
    }
    
}
