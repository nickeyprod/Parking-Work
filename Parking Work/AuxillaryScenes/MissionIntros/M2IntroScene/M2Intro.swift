//
//  M2Intro.swift
//  Parking Work
//
//  Created by Николай Ногин on 20.07.2023.
//

import Foundation
import SpriteKit

class M2Intro: ParkingWorkGame {
    
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
        subtitlesSprite?.position = CGPoint(x: -(displayWidth! / 2) , y: -(displayHeight! / 2) )
        subtitlesSprite?.size.width = displayWidth!
        backImage = self.childNode(withName: "backImage") as? SKSpriteNode
//        backImage?.size.width = displayWidth!
//        backImage?.size.height = 804
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
        
        let t = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { _ in
            self.startSpeach()
        }
        self.speechTimers.append(t)
    }
    
    func startSpeach() {
        backImage?.xScale = 1.2
        backImage?.yScale = 1.2
        backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/01")!)
        speechLabel?.text = "Тачку, которую ты пригнал в последний раз уже разобрали."
        
        let t1 = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
            self.speechLabel?.text = "Федор: Да уж, машинка эта не первой свежести."
        }
        self.speechTimers.append(t1)
        
        let t2 = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
            self.backImage?.xScale = 1.9
            self.backImage?.yScale = 1.9
            self.backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/00")!)
            
            let msg = "Ничего, для начала сойдет, у меня к тебе новая просьба."
            
            self.speechLabel?.attributedText = self.createAttributedString(from: msg)
        }
        
        self.speechTimers.append(t2)
        
        let t3 = Timer.scheduledTimer(withTimeInterval: 16, repeats: false) { _ in
            self.speechLabel?.attributedText = nil
            self.speechLabel?.text = "Будешь в районе Зеленой Аллеи..."
        }
        
        self.speechTimers.append(t3)
        
        let t4 = Timer.scheduledTimer(withTimeInterval: 20, repeats: false) { _ in
            self.speechLabel?.text = "Федор: Я как раз туда собирался, Босс."
        }
        
        self.speechTimers.append(t4)
        
        let t5 = Timer.scheduledTimer(withTimeInterval: 24, repeats: false) { _ in
            self.backImage?.xScale = 1.2
            self.backImage?.yScale = 1.2
            self.backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.6)
            self.backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/02")!)

            let msg = "Это не важно. В том районе живет мой старый приятель Владик. Тебе нужно будет его навестить."

            self.speechLabel?.attributedText = self.createAttributedString(from: msg)
            self.subtitlesSprite?.run(SKAction.resize(toHeight: (self.speechLabel?.frame.height)!, duration: 0.0))
        }
        
        self.speechTimers.append(t5)
        
        let t6 = Timer.scheduledTimer(withTimeInterval: 35, repeats: false) { _ in
            self.backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/00")!)
            self.backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.40)
            let msg = "Владику мы очень помогли в свое время, а он повел себя по-свински, до сих пор не отработал, избегает меня, на звонки не отвечает."
    
            self.speechLabel?.attributedText = self.createAttributedString(from: msg)
            self.subtitlesSprite?.run(SKAction.resize(toHeight: (self.speechLabel?.frame.height)!, duration: 0.0))
        }
        
        self.speechTimers.append(t6)
        
        let t7 = Timer.scheduledTimer(withTimeInterval: 46, repeats: false) { _ in
            self.speechLabel?.attributedText = nil
            self.speechLabel?.text = "Федор: Понимаю о чем вы."
        }
        let t8 = Timer.scheduledTimer(withTimeInterval: 52, repeats: false) { _ in
            self.speechLabel?.text = "Хорошо, тогда заедь к нему и проучи его как следует!"
        }
        let t9 = Timer.scheduledTimer(withTimeInterval: 57, repeats: false) { _ in
            self.speechLabel?.text = "Придумай что-нибудь, запугай его, но не убивай! И шепни ему на ушко мое имя, может вспомнит..."
            
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 65, repeats: false) { _ in
            self.showMission2Scene()
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
        button.alpha = 0.4
        button.zPosition = 12
        self.addChild(button)
        
        let label = SKLabelNode(text: "Пропустить")
        button.name = "skip-label"
        label.position = CGPoint(x: displayWidth! / 2 - 135, y: displayHeight! / 2 - 36)
        
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .bottom
        label.fontSize = 20
        self.addChild(label)
        
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
                showMission2Scene()
                self.releaseSpeechTimers()
            }
         
        }
    }

    func showMission2Scene() {
        let mission1Scene = SKScene(fileNamed: "Mission2Scene")
        let transition = SKTransition.fade(with: .black, duration: 1.0)
        let displaySize: CGRect = UIScreen.main.bounds
        // Set the scale mode to scale to fit the window
        mission1Scene?.scaleMode = .aspectFill
        mission1Scene?.size = displaySize.size
        self.view?.presentScene(mission1Scene!, transition: transition)
    }
}
