//
//  GameScene.swift
//  LyndaParticleEmitters
//
//  Created by Jim Snodgrass on 7/7/14.
//  Copyright (c) 2014 Jim Snodgrass. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        let snowEmmitterPath = NSBundle.mainBundle().pathForResource("snow", ofType: "sks")
        let snow = NSKeyedUnarchiver.unarchiveObjectWithFile(snowEmmitterPath) as SKEmitterNode
        snow.position = CGPointMake(size.width/2, size.height)
        
        addChild(snow)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
