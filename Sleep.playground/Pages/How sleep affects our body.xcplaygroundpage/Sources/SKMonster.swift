import Foundation
import SpriteKit

struct PhysicsCategory {
  static let none      : UInt32 = 0
  static let all       : UInt32 = UInt32.max
  static let monster   : UInt32 = 0b1       // 1
  static let player: UInt32 = 0b10      // 2
  static let wall: UInt32 = 0b100
}



public class SKMonster: SKSpriteNode, SKPhysicsContactDelegate {
    
   public var actualY : CGFloat
   public var loseLife : Int = 3
   public var isAttacking = false
    
    public init(collum: CGFloat) {
        
        let texture = SKTexture(imageNamed: "enemy")
        self.actualY = (collum * 90) - 450
        
        super.init(texture: texture, color: .clear, size: texture.size())
            
            self.physicsBody = SKPhysicsBody(rectangleOf: self.size) // 1
            self.physicsBody?.isDynamic = true // 2
            self.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
            self.physicsBody?.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.wall // 4
            self.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
            self.zPosition = 2
          
          // Determine where to spawn the monster along the Y axis
            
          
          // Position the monster slightly off-screen along the right edge,
          // and along a random position along the Y axis as calculated above
          self.position = CGPoint(x: 420, y: actualY)
          self.scale(to: CGSize(width: 60, height: 60))
     
        
    }
    
    public func hit() {
        isAttacking = false
        self.removeAllActions()
        let actionMove = SKAction.move(to: CGPoint(x: 420, y: actualY),
                                       duration: TimeInterval(0.3))
        
        let saved = self.physicsBody
        self.physicsBody = nil
        self.run(actionMove, completion: {
            
            self.physicsBody = saved
            
        })
    }
    

    
    
    public func attack(sleepHours: Int) {
        
          // Determine speed of the monster
            isAttacking = true
        
            var numMin = 0
            var numMax = 0
            
            if sleepHours >= 7 {
                numMin = 3
                numMax = 4
            } else {
                numMin = 1
                numMax = 2
            }
        
            let actualDuration = (numMin...numMax).randomElement()!
            
          // Create the actions
          let actionMove = SKAction.move(to: CGPoint(x: -420, y: actualY),
                                         duration: TimeInterval(actualDuration))
        //  let actionMoveDone = SKAction.removeFromParent()
            //print("ataquei", self.position)
        
          self.run(actionMove)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
