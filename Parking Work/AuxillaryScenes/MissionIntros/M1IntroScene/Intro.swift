//
//  Intro.swift
//  Parking Work
//
//  Created by Николай Ногин on 08.03.2023.
//

import SpriteKit

class Intro: ParkingWorkGame {
    
    var subtitlesSprite: SKSpriteNode?
    var backImage: SKSpriteNode?
    var speechLabel: SKLabelNode?
    
    var attrMsg: String?
    var attrStr: NSMutableAttributedString = NSMutableAttributedString()
    
    var speechTimers: [Timer?] = []
    
    override func didMove(to view: SKView) {
        setupInitialGameValues()
        
        subtitlesSprite = self.childNode(withName: "subtitlesSprite") as? SKSpriteNode
        subtitlesSprite?.anchorPoint = CGPoint(x: 0, y: 0)
//        subtitlesSprite?.color = .red
        subtitlesSprite?.position = CGPoint(x: -(displayWidth! / 2) , y: -(displayHeight! / 2) )
        subtitlesSprite?.size.width = displayWidth!
        backImage = self.childNode(withName: "backImage") as? SKSpriteNode
        backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/01")!)
        backImage?.xScale = 1
        backImage?.yScale = 1
        backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.40)
        backImage?.size.width = displayWidth!
        backImage?.size.height = 804
        speechLabel = self.childNode(withName: "speechLabel") as? SKLabelNode
        speechLabel?.preferredMaxLayoutWidth = displayWidth! - 100
        speechLabel?.lineBreakMode = .byWordWrapping
        speechLabel?.numberOfLines = 0
        speechLabel?.verticalAlignmentMode = .center
        speechLabel?.horizontalAlignmentMode = .center
        speechLabel?.position = CGPoint(x: (subtitlesSprite?.frame.midX)!, y: (subtitlesSprite?.frame.midY)!)
        
        animateBackImage()
        createSkipButton()
    }
    
    override func setupInitialGameValues() {
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height

    }
    
    func animateBackImage() {
        let act = SKAction.scale(by: 2.0, duration: 103.0)
        backImage?.run(act)
        
        let t = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
            self.startSpeach()
        }
        self.speechTimers.append(t)
    }
    
    func startSpeach() {
        
        backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/01")!)
        speechLabel?.text = "Надеюсь, в последний раз всё прошло тихо?"
        
        let t1 = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
            self.speechLabel?.text = "Федор: Да, Босс."
        }
        self.speechTimers.append(t1)
        
        let t2 = Timer.scheduledTimer(withTimeInterval: 11.0, repeats: false) { _ in
            self.backImage?.xScale = 1.3
            self.backImage?.yScale = 1.3
            self.backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/00")!)
            
            let msg = "Тачку, что ты угнал пригнали к моему дому, прямо под окна и сигналили до тех пор, пока я не вышел на балкон."
            
            self.speechLabel?.attributedText = self.createAttributedString(from: msg)
        }
        
        self.speechTimers.append(t2)
        
        let t3 = Timer.scheduledTimer(withTimeInterval: 17, repeats: false) { _ in
            self.speechLabel?.attributedText = nil
            self.speechLabel?.text = "Если ты все действительно сделал сам, то поздравляю, ты отлично справился."
        }
        
        self.speechTimers.append(t3)
        
        let t4 = Timer.scheduledTimer(withTimeInterval: 21, repeats: false) { _ in
            self.speechLabel?.text = "Федор: Спасибо, Босс."
        }
        
        self.speechTimers.append(t4)
        
        let t5 = Timer.scheduledTimer(withTimeInterval: 23, repeats: false) { _ in
            self.backImage?.xScale = 1.2
            self.backImage?.yScale = 1
            self.backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.6)
            self.backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/02")!)

            let msg = "Так как теперь ты в нашей команде, сегодня ты отправишься на свою первую парковку. Ничего сложного, обычная стоянка в спальном районе, там ты отработаешь свои навыки."

            self.speechLabel?.attributedText = self.createAttributedString(from: msg)
            self.subtitlesSprite?.run(SKAction.resize(toHeight: (self.speechLabel?.frame.height)!, duration: 0.0))
        }
        
        self.speechTimers.append(t5)
        
        let t6 = Timer.scheduledTimer(withTimeInterval: 36, repeats: false) { _ in
            self.backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/00")!)
            self.backImage?.xScale = 1.3
            self.backImage?.yScale = 1.3
            self.backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            let msg = "Марка машины мне не важна, на твое усмотрение. Главное,  доставь её к нам без полиции на хвосте, так чтобы мы убедились в твоих намерениях."
    
            self.speechLabel?.attributedText = self.createAttributedString(from: msg)
            self.subtitlesSprite?.run(SKAction.resize(toHeight: (self.speechLabel?.frame.height)!, duration: 0.0))
        }
        
        self.speechTimers.append(t6)
        
        let t7 = Timer.scheduledTimer(withTimeInterval: 47, repeats: false) { _ in
            self.speechLabel?.attributedText = nil
            self.speechLabel?.text = "Федор: Думаю я сделаю это, не доставив Вам хлопот."
        }
        let t8 = Timer.scheduledTimer(withTimeInterval: 53, repeats: false) { _ in
            self.speechLabel?.text = "Хорошо, вот такие парни нам нужны!"
        }
        let t9 = Timer.scheduledTimer(withTimeInterval: 55, repeats: false) { _ in
            self.showMission1Scene()
        }
        
        self.speechTimers.append(t7)
        self.speechTimers.append(t8)
        self.speechTimers.append(t9)
        

    }
    
    func createSkipButton() {

        let r = CGRect(origin: CGPoint(x: displayWidth! / 2 - 140, y: displayHeight! / 2 - 40), size: CGSize(width: 110, height: 30))
        
        let button = SKShapeNode(rect: r, cornerRadius: 5)
        
        button.name = "skip-btn"
        button.fillColor = UIColor.black
        button.strokeColor = UIColor.gray
        button.alpha = 0.6
        button.zPosition = 12
        self.addChild(button)
        
        let label = SKLabelNode(text: "Пропустить")
        label.name = "skip-label"
        label.position = CGPoint(x: displayWidth! / 2 - 135, y: displayHeight! / 2 - 36)
        
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .bottom
        label.zPosition = 13
        label.fontSize = 20
        button.addChild(label)
        
    }
    
    // release all speech timers for deallocating scene
    func releaseSpeechTimers() {
        self.speechTimers.forEach { t in
            t?.invalidate()
        }
    }
    
    // creates attributed string from usual string for subtitles
    func createAttributedString(from msg: String) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString(string: msg)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let range = NSRange(location: 0, length: msg.count)
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        attrStr.addAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "PT Sans Narrow", size: 26)!
        ], range: range)
        return attrStr
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // buttons pressed check
            let touchedNode = atPoint(location)
            if touchedNode.name == "skip-btn" || touchedNode.name == "skip-label" {
                var btn: SKShapeNode? = nil
                if touchedNode.name == "skip-label" {
                    btn = touchedNode.parent as? SKShapeNode
                } else if touchedNode.name == "skip-btn" {
                    btn = touchedNode as? SKShapeNode
                }
                
                animateButtonClick(button: btn!) {
                    self.showMission1Scene()
                    self.releaseSpeechTimers()
                }
      
            }
         
        }
    }

    func showMission1Scene() {
        let mission1Scene = SKScene(fileNamed: "Mission1Scene")
        let transition = SKTransition.fade(with: .black, duration: 1.0)
        let displaySize: CGRect = UIScreen.main.bounds
        // Set the scale mode to scale to fit the window
        mission1Scene?.scaleMode = .aspectFill
        mission1Scene?.size = displaySize.size
        self.view?.presentScene(mission1Scene!, transition: transition)
    }
}
