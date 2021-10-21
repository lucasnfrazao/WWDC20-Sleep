/*:
![Immune Header](ImmuneGame.png)
 
### Many of us don't sleep well
 
Did you know 62% of adults say that they sleep somewhat/not at all well and just 10% say they sleep extremely well? Unfortunately, for a number of factors, we don't get the necessary 7 to 8 hours of sleep everyday. **And this reduced sleeping cycle can cause various effects on your body.**
  
According to the CDC, adults called, short sleepers (people who sleep less than 7 hours each day) are more likely to report chronic health conditions such as asthma, diabetes and depression. This means that, by not sleeping as much as you need, your body doesn't have enough time to recover from the activities done during the day.
 
During sleep, your body releases proteins called **cytokines**. Those proteins are responsible for fighting infections and inflamations on our immune system. When we don't get enough sleep, the production of cytokines is reduced and this decreases how fast we recover if we get sick.
 
 
Tap **Run my Code** to fight the enemies inside Lucas's immune system. Your goal is to stop **20 of them** from entering the system. First, you should play with 8 hours of sleep. After that, you should change the variable *sleepHours* to less than 7 hours to see the difference!
    
Where you're ready, go to the [next page](@next) to see what we can do to sleep better!
 
*/
//#-hidden-code
import PlaygroundSupport
import SpriteKit

struct PhysicsCategory {
  static let none      : UInt32 = 0
  static let all       : UInt32 = UInt32.max
  static let monster   : UInt32 = 0b1       // 1
  static let player: UInt32 = 0b10      // 2
  static let wall: UInt32 = 0b100
}

func +(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
  func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
  }
#endif

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var lifeLabel: SKLabelNode!
    var gameOver: SKSpriteNode!
    var won: SKSpriteNode!
    var dur : CGFloat = 0
    var timer : Timer!
    let player = SKSpriteNode(imageNamed: "antibody")
    var endLife: SKSpriteNode!
    var isGameComplete = false
    
    let monsters : [SKMonster] = {
        
        var monsters : [SKMonster] = []
        
        for i in 0...8 {
            monsters.append(SKMonster(collum: CGFloat(i)))
        }
        
      return monsters
        
    }()
    
//#-end-hidden-code
var sleepHours = /*#-editable-code*/8/*#-end-editable-code*/
//#-hidden-code

    var life = 3 {
        didSet {
           // life = monster.loseLife
            lifeLabel.text = "Lives: \(life)"
        }
        
    }
    
   var score = 0 {
        didSet {
            scoreLabel.text = "SCORE: \(score)"
        }
    }
       
    var scoreLimit = 20
    
        override func didMove(to view: SKView) {
    
            createBG()
            createPlayer()
            createScore()
            createLifes()
           
            endLife = childNode(withName: "//endLife") as? SKSpriteNode
            gameOver = childNode(withName: "//gameOver") as? SKSpriteNode
            won = childNode(withName: "//won") as? SKSpriteNode
            
            
            
            physicsWorld.gravity = .zero
            physicsWorld.contactDelegate = self
            
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(dur), target: self, selector: #selector(attack), userInfo: nil, repeats: true)
            
            for monster in monsters {
                
                addChild(monster)
                
            }
            
            
        }
    
    @objc func attack() {
        let monsterTime = (self.monsters.filter{!$0.isAttacking}).randomElement()
        monsterTime?.attack(sleepHours: self.sleepHours)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if score == scoreLimit && life >= 1 {
            
            //isGameComplete = true
            
            var finished = 0
            
            timer.invalidate()
            
            if finished == 0 {
            
                let moveMessage = SKAction.move(to:CGPoint(x: won.position.x, y:270), duration: 0.4)
            
            won.run(moveMessage)
            
            }
            
            finished += 1
            
        } else if life == 0 {
            
            timer.invalidate()
            
            
            var finished = 0
            
            timer.invalidate()
            
            if finished == 0 {
                
                let moveMessage = SKAction.move(to:CGPoint(x: gameOver.position.x, y:270), duration: 0.4)
                
                gameOver.run(moveMessage)
                
            }
            
            finished += 1
            
            
        }
        
        if life < 0 {
            
            life = 0
            
        }
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
       
        if let monster = contact.bodyA.node as? SKMonster ?? contact.bodyB.node as? SKMonster {
            
            if contact.bodyA.node == self.player || contact.bodyB.node == self.player {
                
                score += 1
                monster.hit()
                
                
            } else if contact.bodyA.node == self.endLife || contact.bodyB.node == self.endLife {
                
                life -= 1
                monster.hit()
                
            }
            
            
            
        }
        
        
        
    }
    
    func createScore() {
        scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        scoreLabel.fontSize = 24

        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 60)
        scoreLabel.text = "SCORE: 0"
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 1

        if sleepHours >= 7 {
            
            dur = 0.8
        } else {
            
            dur = 0.5
        }
        
        addChild(scoreLabel)
    }
    
    func createLifes() {
        lifeLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        lifeLabel.fontSize = 20

        lifeLabel.position = CGPoint(x: frame.midX - 200, y: frame.maxY - 60)
        lifeLabel.text = "Lives: 3"
        lifeLabel.fontColor = UIColor.white
        lifeLabel.zPosition = 1
        
        addChild(lifeLabel)
    }
    
    func createPlayer() {
         player.position = CGPoint(x: 0, y: 0)
         player.anchorPoint = CGPoint(x: 0.2, y: 0.5)
         
         player.scale(to: CGSize(width: 160, height: 120))
         player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
         player.physicsBody?.isDynamic = true
         player.physicsBody?.categoryBitMask = PhysicsCategory.player
         player.physicsBody?.contactTestBitMask = PhysicsCategory.monster
         player.physicsBody?.collisionBitMask = PhysicsCategory.none
         player.physicsBody?.usesPreciseCollisionDetection = true
         player.zPosition = 2
        
        addChild(player)
    }
    
        
    func createBG() {
        
        let BGTexture = SKTexture(imageNamed: "pattern")
        
        for i in 0...1 {
            
            let bg = SKSpriteNode(texture: BGTexture)
            bg.name = "BG"
            bg.size = CGSize(width:770, height: 1024)
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0)
            bg.zPosition = 0
            
            let moveLeft = SKAction.moveBy(x: -BGTexture.size().width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: BGTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            
            bg.run(moveForever)
            addChild(bg)
        }
     
    }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                
                let location = t.location(in: self)
                
                player.position.x = location.x
                player.position.y = location.y
             
            }
            
          
            
        }
    }



// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    // Present the scene
    sceneView.preferredFramesPerSecond = 60
   // sceneView.showsFPS = true
    sceneView.ignoresSiblingOrder = true
    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView

 //#-end-hidden-code

 
