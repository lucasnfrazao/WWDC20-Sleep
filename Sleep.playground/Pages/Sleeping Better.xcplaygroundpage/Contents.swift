/*:
![Sleep Better Header](sleepBetterBG.png)
 
### What we can do to sleep better?
 
As we've seen before, the lack of sleep can have serious mental and physical implications to your body.
 
In order to have a good night's sleep, there are some things you should do or avoid doing before going to bed:
 
* Turn off all lights and any source of sound that could disturb your sleep
* Turn off  any TVs and avoid using your phone right before sleep
* Avoid drinking coffee or anything that has caffeine
* Avoid having large meals right before going to bed

 
* Callout(Remember):
 It's also very important to mantain the same sleeping schedule every day!
 
Now that we've talked a bit about what we should and should not do before going to bed, you will have **15 seconds** to help Lucas sleep. He has an important exam tomorrow and needs to wake up early in the morning. Your goal is to find 4 objects related to what we can do to sleep better.

When you're ready, tap **Run my Code** to help Lucas fall asleep!

**Tip:** Tap other objects and see some easter eggs 👾
*/

//#-hidden-code
import Foundation
import SpriteKit
import PlaygroundSupport


class BetterSleep: SKScene {
    
    //Menu
    let bgMenu = SKSpriteNode()
    var bgFinal = SKSpriteNode()
    var imageStart = SKSpriteNode()
    var imageFinal = SKSpriteNode()
    var isMenuDismiss = false
    var isGameCompleted = false
    var isWin = true
    var congratsMessage : SKSpriteNode!
    var timeUp : SKSpriteNode!
    
    //Timer
    var renderTime: TimeInterval = 0.0
    var changeTime: TimeInterval = 1
    var seconds: Int = 0
    var minutes: Int = 0
    var label:SKLabelNode = SKLabelNode()
    
    //Points
    var points: Int = 0
    var finishes: Int = 0
    var progressBar = SKShapeNode()
    var progress = SKShapeNode()
    
    //Objects
    var fruit : SKSpriteNode!
    var memoji: SKSpriteNode!
    var books: SKSpriteNode!
    var light: SKSpriteNode!
    var phone: SKSpriteNode!
    var clock: SKSpriteNode!
    var guitar: SKSpriteNode!
    var homepod: SKSpriteNode!
    var tv: SKSpriteNode!
    var chocolate: SKSpriteNode!
    var message: SKLabelNode!
    var numberObjects: SKLabelNode!
    
    //Selected
    var isTVSelected = false
    var isLightSelected = false
    var isFruitSelected = false
    var isPhoneSelected = false
    
    
    override public func didMove(to view: SKView) {
        

        
        fruit = childNode(withName: "//fruit") as? SKSpriteNode
        memoji = childNode(withName: "//memoji") as? SKSpriteNode
        books = childNode(withName: "//books") as? SKSpriteNode
        light = childNode(withName: "//light") as? SKSpriteNode
        phone = childNode(withName: "//phone") as? SKSpriteNode
        chocolate = childNode(withName: "//chocolate") as? SKSpriteNode
        clock = childNode(withName: "//clock") as? SKSpriteNode
        guitar = childNode(withName: "//guitar") as? SKSpriteNode
        tv = childNode(withName: "//tv") as? SKSpriteNode
        congratsMessage = childNode(withName: "//congratsMessage") as? SKSpriteNode
        timeUp = childNode(withName: "//timeUp") as? SKSpriteNode
        homepod = childNode(withName: "//homepod") as? SKSpriteNode
        message = childNode(withName: "//message") as? SKLabelNode
        numberObjects = childNode(withName: "//numberObjects") as? SKLabelNode
        
        message.isHidden = true
        createMenu(imagename: "HelpLucas")
        createLabel()
        
        
   
        
        
        
    }
    
    override public func didChangeSize(_ oldSize: CGSize) {
        label.position.x = self.size.width/2
        label.position.y = self.size.height/2
    }
    
    override public func update(_ currentTime: TimeInterval) {
        if currentTime > renderTime{
            if isMenuDismiss && isGameCompleted == false && seconds < 15 {
            if renderTime > 0{
                seconds += 1
                if seconds == 60 {
                    seconds = 0
                    minutes += 1
                }
                let secondsText = (seconds < 10) ? "0\(seconds)" : "\(seconds)"
                let minutesText = (minutes < 10) ? "0\(minutes)" : "\(minutes)"
                label.text = "\(minutesText) : \(secondsText)"
            }
            renderTime = currentTime + changeTime
            
            
        }
             
        }
        
        
        numberObjects.text = "\(points)/4"
        
        if points <= 3 && seconds >= 15 {
                    
               //label.text = "00:30"
               
               if finishes == 0 {
               
               let moveMessage = SKAction.move(to:CGPoint(x: timeUp.position.x, y: timeUp.position.y - 400), duration: 0.4)
                   timeUp.run(moveMessage)
                   timeUp.zPosition = 1
               }
                   
               finishes += 1
            
            scene?.isUserInteractionEnabled = false
                    
           }
        
        
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first as UITouch?
        let touchLocation = touch?.location(in: self)
        //let targetNode = atPoint(touchLocation!) as! SKSpriteNode
        
        if isMenuDismiss {
            
            //Objects that need to be selected
            
            if isFruitSelected == false {
                
        
                
                if  fruit.contains(touchLocation!) {
                    message.isHidden = false
                    message.text = "If you're hungry before sleep, you can eat a small healthy snack like apples!"
                    message.lineBreakMode = .byWordWrapping
                    message.numberOfLines = 2
                    message.preferredMaxLayoutWidth = 700
                    
                    fruit.alpha = 0.2
                    isFruitSelected = true
                    
                    points += 1
                    
                }
                
                
            }
            
            if isTVSelected == false {
                
                if tv.contains(touchLocation!) {
                    
                    message.isHidden = false
                    message.text = "It's not recommended to use TVs before sleep."
                    
                    tv.alpha = 0.2
                    isTVSelected = true
                    points += 1
                    
                }
                
            }

            if isLightSelected == false {
            
            if light.contains(touchLocation!) {
                
                message.isHidden = false
                message.text = "Turning off lights can help you sleep better!"
                light.alpha = 0.2
                light.run(SKAction.setTexture(SKTexture(imageNamed: "lightOff")))
                isLightSelected = true
                points += 1
                
            }
            
                }
            
            if isPhoneSelected == false {
            
            if phone.contains(touchLocation!) {
                
                message.isHidden = false
                message.text = "You shouldn't use your phone before going to bed."
                
                phone.alpha = 0.2
                isPhoneSelected = true
                points += 1
                
                
            }
            
        }
            
        //Other objects and easter eggs
            
            if chocolate.contains(touchLocation!) {
                
                message.isHidden = false
                message.text = "You should avoid eating chocolate before sleeping."
                
                
                
            }
            
            
    
        if memoji.contains(touchLocation!) {
            
            message.isHidden = false
            message.text = "This is Lucas coding a playground 😜"
            
        }
         
            
        if books.contains(touchLocation!) {
                
            message.isHidden = false
            message.text = "Lucas loves reading books 📚"
                
        }
        
        if clock.contains(touchLocation!) {
                    
            message.isHidden = false
            message.text = "It's 9:41 p.m.📱!"
            
                
        }
            
        if guitar.contains(touchLocation!) {
                    
            message.isHidden = false
            message.text = "Lucas likes playing the guitar 🎸"
            
                
        }
            
        if homepod.contains(touchLocation!) {
                    
            message.isHidden = false
            message.text = "\"Hey Siri, play Ambient Sounds\""
            
                
        }
       
        }
        
        if imageStart.contains(touchLocation!) {
            
            isMenuDismiss = true
            removeChildren(in: [imageStart, bgMenu])
            
        }
        
        if points == 4 && seconds <= 15 {
            
            isGameCompleted = true
            
            if finishes == 0 {
            
            let moveMessage = SKAction.move(to:CGPoint(x: congratsMessage.position.x, y: congratsMessage.position.y - 400), duration: 0.4)
            congratsMessage.run(moveMessage)
                congratsMessage.zPosition = 1
            }
                
            finishes += 1
            
            scene?.isUserInteractionEnabled = false
        }
        

        
        
        
        
    }
    
    func createMenu(imagename: String) {

        bgMenu.size = CGSize(width: 768, height: 1024)
        bgMenu.color = UIColor(white: 0, alpha: 0.7)
        
        self.addChild(bgMenu)
        
        imageStart = SKSpriteNode(imageNamed: imagename)
        
        imageStart.size = CGSize(width: 504, height: 250)
        
        self.addChild(imageStart)
        
    }
    
    func createEnding() {

        bgFinal.size = CGSize(width: 768, height: 1024)
        bgFinal.color = UIColor(white: 0, alpha: 0.7)
        
        self.addChild(bgFinal)
        
        imageFinal = SKSpriteNode(imageNamed: "congratulations")
        
        imageFinal.size = CGSize(width: 504, height: 250)
        
        self.addChild(imageFinal)
        
    }
    
    
    func createLabel() {
        
        label.text = "00 : 00"
        label = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        label.fontSize = 24
        label.position = CGPoint(x: frame.midX - 240, y: frame.maxY - 105)
        label.fontColor = UIColor.white
        
        
        self.addChild(label)
        
        
    }
    
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = BetterSleep(fileNamed: "BetterSleep") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}
PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code
