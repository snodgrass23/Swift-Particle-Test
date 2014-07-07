//
//  GameScene.swift
//  LyndaParticleEmitters
//
//  Created by Jim Snodgrass on 7/7/14.
//  Copyright (c) 2014 Jim Snodgrass. All rights reserved.
//

import SpriteKit
import Foundation
import AVFoundation

class GameScene: SKScene {
    
    let spaceship = SKSpriteNode(imageNamed: "Spaceship")
    let engineSound = SKAction.playSoundFileNamed("engine.wav", waitForCompletion: false)
    
    var touching = false
    
    let snow = NSKeyedUnarchiver.unarchiveObjectWithFile(
        NSBundle.mainBundle().pathForResource("snow", ofType: "sks")) as SKEmitterNode
    let engineParticles = NSKeyedUnarchiver.unarchiveObjectWithFile(
        NSBundle.mainBundle().pathForResource("EngineParticle", ofType: "sks")) as SKEmitterNode
    
    override func didMoveToView(view: SKView) {
        setupScene()
        addSnow()
        addSpaceship()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        touching = true
        engineParticles.particleBirthRate = 500
        SKAction.repeatActionForever(engineSound)
        
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        touching = false
        engineParticles.particleBirthRate = 10
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if touching {
            spaceship.physicsBody.applyForce(CGVectorMake(0, 150))
            runAction(engineSound)
        }
    }
    
    func setupScene() {
        backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        physicsWorld.gravity = CGVectorMake(0, -0.6)
    }
    
    func addSpaceship() {
        engineParticles.position = CGPointMake(0, -spaceship.size.height/2)
        engineParticles.particleBirthRate = 10
        spaceship.addChild(engineParticles)
        
        spaceship.xScale = 0.25
        spaceship.yScale = 0.25
        spaceship.position = CGPointMake(size.width/2, size.height/2 - 100)
        spaceship.physicsBody = SKPhysicsBody(rectangleOfSize: spaceship.size)
        addChild(spaceship)
    }
    
    func addSnow() {
        snow.position = CGPointMake(size.width/2, size.height)
        snow.advanceSimulationTime(10.0)
        addChild(snow)
    }
}
