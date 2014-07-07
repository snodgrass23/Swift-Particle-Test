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
    let engineSound = SKAction.playSoundFileNamed("engine.wav", waitForCompletion: true)
    
    var lastUpdateTimeInterval: CFTimeInterval = 0
    var touching = false
    
    let snow = NSKeyedUnarchiver.unarchiveObjectWithFile(
        NSBundle.mainBundle().pathForResource("snow", ofType: "sks")) as SKEmitterNode
    let engineParticles = NSKeyedUnarchiver.unarchiveObjectWithFile(
        NSBundle.mainBundle().pathForResource("EngineParticle", ofType: "sks")) as SKEmitterNode
    
    override func didMoveToView(view: SKView) {
        setupScene()
        addSpaceship()
        addSnow()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        touching = true
        engineParticles.particleBirthRate = 500
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        touching = false
        engineParticles.particleBirthRate = 10
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        let timeSinceLast = currentTime - lastUpdateTimeInterval
        
        if touching {
            spaceship.physicsBody.applyForce(CGVectorMake(0, 75))
            if timeSinceLast > 0.2 {
                lastUpdateTimeInterval = currentTime
                runAction(engineSound)
            }
        }
    }
    
    func setupScene() {
        backgroundColor = SKColor.blackColor()
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        physicsWorld.gravity = CGVectorMake(0, -0.5)
        physicsBody.restitution = 0
    }
    
    func addSpaceship() {
        engineParticles.position = CGPointMake(0, -spaceship.size.height/2)
        engineParticles.particleBirthRate = 10
        spaceship.addChild(engineParticles)
        
        spaceship.xScale = 0.25
        spaceship.yScale = 0.25
        spaceship.position = CGPointMake(size.width/2, size.height/2 - 100)
        spaceship.physicsBody = SKPhysicsBody(rectangleOfSize: spaceship.size)
        spaceship.physicsBody.restitution = 0
        spaceship.physicsBody.friction = 0
        spaceship.zPosition = 10
        addChild(spaceship)
    }
    
    func addSnow() {
        snow.position = CGPointMake(size.width/2, size.height)
        snow.advanceSimulationTime(10.0)
        addChild(snow)
    }
}
