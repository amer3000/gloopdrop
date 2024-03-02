//
//  Collectible.swift
//  gloopdrop
//
//  Created by Amer Khalid on 2/9/24.
//

import Foundation
import SpriteKit

enum CollectibleType: String {
    case none
    case gloop
}

class Collectible: SKSpriteNode {
    private var collectibleType: CollectibleType = .none

    init(collectibleType: CollectibleType) {
        var texture: SKTexture!
        self.collectibleType = collectibleType

        switch self.collectibleType {
        case .none:
            break
        case .gloop:
            texture = SKTexture(imageNamed: "gloop")
        }

        super.init(texture: texture, color: SKColor.clear, size: texture.size())

        self.name = "co_|(collectibleType)"
        self.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.zPosition = Layer.collectible.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NOTTTT Implemented")
    }

    // MARK: - FUNTIONS
    func drop(dropSpeed: TimeInterval, floorLevel: CGFloat) {
        let pos = CGPoint(x: position.x, y: floorLevel)

        let scaleX = SKAction.scaleX(to: 1.0, duration: 1.0)
        let scaleY = SKAction.scaleY(to: 1.3, duration: 1.0)
        let scale = SKAction.group([scaleX, scaleY])

        let appear = SKAction.fadeAlpha(by: 1.0, duration: 0.25)
        let moveAction = SKAction.move(to: pos, duration: dropSpeed)
        let actionSequence = SKAction.sequence([appear, scale, moveAction])

        self.scale(to: CGSize(width: 0.25, height: 1.0))
        self.run(actionSequence, withKey: "drop")
    }

}
