/*:
![Sleep Header](sleep_bg_v2.png)
 
Today, we're going to talk about **sleep**. This is when your body has the chance to recover from wear and tear of your daily routine. It's super important for your ability to memorize and learn. And it also helps your immune system by increasing the production of proteins needed to fight infections.
  

**The sleep cycle has 2 main stages:**
 
* **Non-Rapid Eye Movement (NREM)**
 
* **Rapid Eye Movement (REM)**

  
The non-REM is divided in three phases, each lasting from 5 to 15 minutes. In the first one, your eyes are closed and it's still easy to be woken up. The second phase begins with your body lowering your heart rate, temperature and breathing rate and getting prepared for deep sleep. The final phase is where deep sleep starts. It is when your body repairs tissues, increases the proteins and builds bone and muscle.
 
The REM stage is marked by the period when our brain is most active during sleep. Starting, usually, 90 minutes after falling asleep, it's when we have most of our dreams. It also helps consolidated information and process memories gathered throughout the day.

Now that we've seen how the sleep cycle works tap **Run my Code** to help Lucas through the two stages of the sleep cycle.
 
During the first stage, your goal is to change the **System Controls** according to what we just learned. In the second stage, you'll need to **find all objects** to create Lucas's dreams and **consolidate his memories**.

When you're ready, go to [next page](@next) to see how sleep affects our body!
  
 */
//#-hidden-code
import PlaygroundSupport
import UIKit
import SpriteKit

class SleepScene: SKScene {
    
    private var label : SKLabelNode!
    private var spinnyNode : SKShapeNode!
    
    //Menu
    let bgMenu = SKSpriteNode()
    var imageStart = SKSpriteNode()
    var isMenuDismiss = false
    var goToStage: SKSpriteNode!
    
    var isMemojiSleep = false
    var isHeartRateLow = false
    var isBreethingRateLow = false
    
    //Labels
    var stage: SKLabelNode!
    var desc: SKLabelNode!
    var breethLabel: SKLabelNode!
    var heartLabel: SKLabelNode!
    var eyesLabel: SKLabelNode!
    var system: SKLabelNode!
    
    //Objects
    var eyesClosedBG: SKSpriteNode!
    var eyesOpenBG: SKSpriteNode!
    var eyesOpen: SKSpriteNode!
    var eyesClosed: SKSpriteNode!
    var heart: SKSpriteNode!
    var lung: SKSpriteNode!
    var memoji: SKSpriteNode!
    
    override public func didMove(to view: SKView) {

        
        eyesClosedBG = childNode(withName: "//eyesClosedBG") as? SKSpriteNode
        eyesOpenBG = childNode(withName: "//eyesOpenBG") as? SKSpriteNode
        memoji = childNode(withName: "//memoji") as? SKSpriteNode
        heart = childNode(withName: "//heart") as? SKSpriteNode
        lung = childNode(withName: "//lung") as? SKSpriteNode
        goToStage = childNode(withName: "//goToStage") as? SKSpriteNode
        
        
        stage = childNode(withName: "//stage") as! SKLabelNode
        desc = childNode(withName: "//desc") as! SKLabelNode
        breethLabel = childNode(withName: "//breethLabel") as! SKLabelNode
        heartLabel = childNode(withName: "//heartLabel") as! SKLabelNode
        eyesLabel = childNode(withName: "//eyesLabel") as! SKLabelNode
        system = childNode(withName: "//system") as! SKLabelNode
        
        
      
        
        
        goToStage.isHidden = true
        
    }
    
    @objc static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
     
    
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

        
    }
    
    func touchUp(atPoint pos : CGPoint) {
     
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
       // let targetNode = atPoint(touchLocation!) as? SKSpriteNode
        
        if eyesClosedBG.contains(touchLocation!) {
            let fadeOut = SKAction.fadeOut(withDuration: 0.3)
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            
            let changeTexture = SKAction.setTexture(SKTexture(imageNamed: "sleeping"))
            
            let scale = SKAction.scale(to: CGSize(width: 301.6, height: 303.2), duration: 0.1)
            scale.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([fadeOut, changeTexture, scale, fadeIn])
            
            
            memoji.run(sequence)
            
            eyesClosedBG.color = UIColor(red: 0.26, green: 0.28, blue: 0.60, alpha: 1.00)
            
            eyesOpenBG.color = UIColor(red: 0.10, green: 0.09, blue: 0.21, alpha: 1.00)
            
            
            isMemojiSleep = true
            
        } else if eyesOpenBG.contains(touchLocation!) {
           
            let fadeOut = SKAction.fadeOut(withDuration: 0.3)
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            
            let changeTexture = SKAction.setTexture(SKTexture(imageNamed: "memoji_smile"))
            
            let scale = SKAction.scale(to: CGSize(width: 226.4, height: 287.2), duration: 0.1)
            scale.timingMode = .easeInEaseOut
            
            let sequence = SKAction.sequence([fadeOut, changeTexture, scale, fadeIn])
            
            
           memoji.run(sequence)

            eyesClosedBG.color =
                UIColor(red: 0.10, green: 0.09, blue: 0.21, alpha: 1.00)
            
           
            eyesOpenBG.color = UIColor(red: 0.26, green: 0.28, blue: 0.60, alpha: 1.00)
            
            isMemojiSleep = false
          
        }
        
        if isHeartRateLow == false {
            if heart.contains(touchLocation!) {
            
            let moveHeart = SKAction.move(to:CGPoint(x: heart.position.x, y: heart.position.y - 90), duration: 0.3)
            
            heart.run(moveHeart)
            isHeartRateLow = true
            
            heart.isUserInteractionEnabled = false
            
            }
        }
        
        if isBreethingRateLow == false {
        
        if lung.contains(touchLocation!) {
        
            
            let moveLung = SKAction.move(to:CGPoint(x: lung.position.x, y: lung.position.y - 90), duration: 0.3)
            
            lung.run(moveLung)
      
            isBreethingRateLow = true
            
            lung.isUserInteractionEnabled = false
            
        }
            
        }
        
        if isMemojiSleep && isHeartRateLow && isBreethingRateLow {
            
            goToStage.isHidden = false
            
            if goToStage.contains(touchLocation!) {
                
                if let scene = Stage2(fileNamed: "SleepStage2") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    sceneView.presentScene(scene)
                }
                
                
            }
            
        }
        
        
        
    }
    
    func createMenu() {
        
    
               
        bgMenu.size = CGSize(width: 768, height: 1024)
        bgMenu.color = UIColor(white: 0, alpha: 0.7)
               
        bgMenu.isHidden = true
               
        self.addChild(bgMenu)
               
        //return bgMenu
        
        imageStart = SKSpriteNode(imageNamed: "stage1_finished")
        
        imageStart.size = CGSize(width: 504, height: 250)
        
        self.addChild(imageStart)
       
        
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
    }
}

enum CattegoryTypes: UInt32 {
    case player = 0b1
    case wall = 0b10
    case dream = 0b100
    case heal = 0b1000
    case finish = 0b10000
}



class Stage2: SKScene, SKPhysicsContactDelegate {

    let player = SKSpriteNode(imageNamed: "sleepingPlayer")
    var box : SKSpriteNode!
    
    var dream1: SKSpriteNode!
    var dream2: SKSpriteNode!
    var dream3: SKSpriteNode!
    
    var isDream1 = false
    var isDream2 = false
    var isDream3 = false
    
    var memory1: SKSpriteNode!
    var memory2: SKSpriteNode!
    var memory3: SKSpriteNode!
    
    var memoryScore: SKLabelNode!
    var dreamScore: SKLabelNode!
    
    var remStage: SKSpriteNode!
    
    var end: SKSpriteNode!
    
    var dream = SKSpriteNode()
    
    var pointsDream = 0
    var pointsMemory = 0
    
    override public func didMove(to view: SKView) {

        box = childNode(withName: "//box") as? SKSpriteNode
        dream1 = childNode(withName: "//dream1") as? SKSpriteNode
        dream2 = childNode(withName: "//dream2") as? SKSpriteNode
        dream3 = childNode(withName: "//dream3") as? SKSpriteNode
        
        
        memory1 = childNode(withName: "//memory1") as? SKSpriteNode
        memory2 = childNode(withName: "//memory2") as? SKSpriteNode
        memory3 = childNode(withName: "//memory3") as? SKSpriteNode
        
        end = childNode(withName: "//end") as? SKSpriteNode
        remStage = childNode(withName: "//remStage") as? SKSpriteNode
        
        memoryScore = childNode(withName: "//memoryScore") as? SKLabelNode
        dreamScore = childNode(withName: "//dreamScore") as? SKLabelNode
        
        createPlayerBox()
        end.isHidden = true
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }

    
    func didBegin(_ contact: SKPhysicsContact) {
        let hittedNode = contact.bodyA.node == player ? contact.bodyB.node : contact.bodyA.node

        //print(hittedNode?.name)
        switch hittedNode {
            case dream1:
                pointsDream += 1
                hittedNode?.removeFromParent()
            case dream2:
                pointsDream += 1
                hittedNode?.removeFromParent()
            case dream3:
                pointsDream += 1
                hittedNode?.removeFromParent()
            case memory1, memory2, memory3:
                pointsMemory += 1
                hittedNode?.removeFromParent()
            case end:
                let moveToCenter = SKAction.moveTo(y: remStage.position.y - 320, duration: 0.7)
                remStage.run(moveToCenter)
                hittedNode?.removeFromParent()
                scene?.isPaused
            default:
            break
        }

    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
//        let touch = touches.first!
//        let location = touch.location(in: self)
        
//        let move = SKAction.move(to: location, duration: 0.1)
//
//        if !location.isOutside(box.frame) {
//
//        player.run(move)
//
//        }
        
        
        for t in touches {

            let location = t.location(in: self)

            if !location.isOutside(box.frame) {
            
            player.position.x = location.x
            player.position.y = location.y

            }
                
        }
            
        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {

        if pointsDream >= 3 && pointsMemory >= 3 {
            end.isHidden = false
          
        }

        
    }
    
    
    func createPlayerBox() {
         
        player.position = CGPoint(x: -254.05, y:232.619)
         
        player.scale(to: CGSize(width: 50, height: 50))
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/4)
     
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.friction = 0
        player.physicsBody?.categoryBitMask = CattegoryTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CattegoryTypes.dream.rawValue | CattegoryTypes.heal.rawValue | CattegoryTypes.finish.rawValue


        addChild(player)
   
    }
    
    
}


    
extension CGPoint {
   
    func isOutside(_ other:CGRect)->Bool {
        
        return self.x < other.minX ||
            self.x > other.maxX ||
            self.y < other.minX ||
            self.y > other.maxY
    }
}
    




// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = SleepScene(fileNamed: "Sleep") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    //sceneView.showsFPS = true
    //sceneView.showsPhysics = true
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code



