//
//  GameScene.swift
//  gloopdrop
//
//  Created by Amer Khalid on 11/1/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let player = Player()
    let playerSpeed: CGFloat = 1.5

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background_1")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.background.rawValue
        background.position = CGPoint(x: 0, y: 0)
        addChild(background)
        
        // foreground
        let foreground = SKSpriteNode(imageNamed: "foreground_1")
        foreground.anchorPoint = CGPoint(x: 0, y: 0)
        foreground.zPosition = Layer.foreground.rawValue
        foreground.position = CGPoint(x: 0, y: 0)
        addChild(foreground)
        
        player.position = CGPoint(x: size.width/2, y: foreground.frame.maxY)
        player.setupConstraints(floor: foreground.frame.maxY)
        addChild(player)
        player.walk()

        spawnMultipleGloops()
    }

    // MARK: - GAME FUNCTIONS

    func spawnMultipleGloops() {
        let wait = SKAction.wait(forDuration: TimeInterval(1.0))
        let spawn = SKAction.run { [unowned self] in self.spawnGloop() }
        let sequence = SKAction.sequence([wait, spawn])
        let repeatAction = SKAction.repeat(sequence, count: 10)

        run(repeatAction, withKey: "gloop")
    }

    func spawnGloop() {
        let collectible = Collectible(collectibleType: CollectibleType.gloop)

        let margin = collectible.size.width * 2
        let dropRange = SKRange(lowerLimit: frame.minX + margin,
                                upperLimit: frame.maxX - margin)
        let randomX = CGFloat.random(in: dropRange.lowerLimit...dropRange.upperLimit)

        collectible.position = CGPoint(x: randomX,
                                       y: player.position.y * 2.5)

        addChild(collectible)
        collectible.drop(dropSpeed: TimeInterval(1.0), floorLevel: player.frame.minY)
    }

    // MARK: - Touch Handling

    func touchDown(atPoint pos : CGPoint) {
        let distance = hypot(pos.x-player.position.x, pos.y-player.position.y)
        let calculatedSpeed = TimeInterval(distance / playerSpeed) / 255
        
        if pos.x < player.position.x {
            player.moveToPosition(pos: pos, direction: "L", speed: calculatedSpeed)
        } else {
            player.moveToPosition(pos: pos, direction: "R", speed: calculatedSpeed)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
}
