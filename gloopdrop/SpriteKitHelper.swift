//
//  SpriteKitHelper.swift
//  gloopdrop
//
//  Created by Amer Khalid on 1/14/24.
//

import Foundation
import SpriteKit

// MARK: - SpriteKit Helpers

// Set up shared z-position
enum Layer: CGFloat {
    case background
    case foreground
    case player
    case collectible
}

enum PhysicsCategory {
    static let none: UInt32 = 0
    static let player: UInt32 = 0b1
    static let collectible: UInt32 = 0b10
    static let foreground: UInt32 = 0b100

}

// MARK: - SPRITEKIT EXTENSIONS

extension SKSpriteNode {
    // Used to load texture arrays for animations
    func loadTextures(atlas: String, prefix: String, startsAt: Int, stopsAt: Int) -> [SKTexture] {
        var textureArray = [SKTexture]()
        let textureAtlas = SKTextureAtlas(named: atlas)
        for i in startsAt...stopsAt {
            let textureName = "\(prefix)\(i)"
            let temp = textureAtlas.textureNamed(textureName)
            textureArray.append(temp)
        }
        
        return textureArray
    }
    
    // Start animation
    func startAnimation(textures: [SKTexture], speed: Double, name: String,
                        count: Int, resize: Bool, restore: Bool) {
        if (action(forKey: name) == nil) {
            let animation = SKAction.animate(with: textures, timePerFrame: speed, resize: resize, restore: restore)
            
            if count == 0 {
                let repeatAction = SKAction.repeatForever(animation)
                run(repeatAction, withKey: name)
            } else if count == 1 {
                run(animation, withKey: name)
            } else {
                let repeatAction = SKAction.repeat(animation, count: count)
                run(repeatAction, withKey: name)
            }
        }
    }
}
