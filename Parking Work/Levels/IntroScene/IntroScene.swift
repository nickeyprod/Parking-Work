//
//  IntroScene.swift
//  Parking Work
//
//  Created by Николай Ногин on 08.03.2023.
//

import SpriteKit

class IntroScene: ParkingWorkGame {
    
    var subtitlesSprite: SKSpriteNode?
    var backImage: SKSpriteNode?
    var speechLabel: SKLabelNode?
    
    var attrMsg: String?
    var attrStr: NSMutableAttributedString = NSMutableAttributedString()
    
    var speechTimers: [Timer?] = []
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupInitialGameValues()
        
        subtitlesSprite = self.childNode(withName: "subtitlesSprite") as? SKSpriteNode
        backImage = self.childNode(withName: "backImage") as? SKSpriteNode
        speechLabel = self.subtitlesSprite?.childNode(withName: "speachLabel") as? SKLabelNode
        speechLabel?.preferredMaxLayoutWidth = displayWidth! - 100
        speechLabel?.lineBreakMode = .byWordWrapping
        speechLabel?.numberOfLines = 0
        speechLabel?.verticalAlignmentMode = .center
        speechLabel?.horizontalAlignmentMode = .center
        
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
            print("start speech")
        }
        self.speechTimers.append(t)
    }
    
    func startSpeach() {
        backImage?.xScale = 2.0
        backImage?.yScale = 1.8
        backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.3)
        
        backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/01")!)
        speechLabel?.text = "Надеюсь, в последний раз всё прошло тихо?"
        
        let t1 = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
            self.speechLabel?.text = "Федор: Да, Босс. Прошло без нервов."
        }
        self.speechTimers.append(t1)
        
        let t2 = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
            self.backImage?.xScale = 1.9
            self.backImage?.yScale = 1.9
            self.backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/00")!)
            
            let msg = "Панов пригнал твою \"работу\" ко мне прямо под окна и сигналил до тех пор, пока я не вышел на балкон."
            
            self.speechLabel?.attributedText = self.createAttributedString(from: msg)
        }
        
        self.speechTimers.append(t2)
        
        let t3 = Timer.scheduledTimer(withTimeInterval: 16, repeats: false) { _ in
            self.speechLabel?.attributedText = nil
            self.speechLabel?.text = "Если это так, то поздравляю, ты отлично справился."
        }
        
        self.speechTimers.append(t3)
        
        let t4 = Timer.scheduledTimer(withTimeInterval: 20, repeats: false) { _ in
            self.speechLabel?.text = "Федор: Спасибо, Босс."
        }
        
        self.speechTimers.append(t4)
        
        let t5 = Timer.scheduledTimer(withTimeInterval: 24, repeats: false) { _ in
            self.backImage?.xScale = 1.9
            self.backImage?.yScale = 1.9
            self.backImage?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/02")!)
            let msg = "Так как теперь ты в нашей команде, сегодня ты отправишься на свою первую парковку. Ничего сложного, обычная стоянка в спальном районе, там ты отработаешь свои навыки."

            self.speechLabel?.attributedText = self.createAttributedString(from: msg)
        }
        
        self.speechTimers.append(t5)
        
        let t6 = Timer.scheduledTimer(withTimeInterval: 35, repeats: false) { _ in
            self.backImage?.texture = SKTexture(image: UIImage(named: "IntroScene/00")!)
            let msg = "Марка машины мне не важна, на твое усмотрение. Главное,  доставь её к нам без полиции на хвосте, так чтобы мы убедились в твоих намерениях."
    
            self.speechLabel?.attributedText = self.createAttributedString(from: msg)
        }
        
        self.speechTimers.append(t6)
        
        let t7 = Timer.scheduledTimer(withTimeInterval: 46, repeats: false) { _ in
            self.speechLabel?.attributedText = nil
            self.speechLabel?.text = "Федор: Думаю я сделаю это, не доставив Вам хлопот."
        }
        let t8 = Timer.scheduledTimer(withTimeInterval: 52, repeats: false) { _ in
            self.speechLabel?.text = "Хорошо, вот такие парни нам нужны!"
        }
        let t9 = Timer.scheduledTimer(withTimeInterval: 54, repeats: false) { _ in
            self.showLevel1Scene()
        }
        
        self.speechTimers.append(t7)
        self.speechTimers.append(t8)
        self.speechTimers.append(t9)
        

    }
    
    func createSkipButton() {

        let r = CGRect(origin: CGPoint(x: displayWidth! / 2.2, y: displayHeight! / 2), size: CGSize(width: 110, height: 30))
        let button = SKShapeNode(rect: r, cornerRadius: 5)
        button.name = "skip-btn"
        button.fillColor = UIColor.black
        button.strokeColor = UIColor.gray
        button.alpha = 0.4
        button.zPosition = 12
        self.addChild(button)
        
        let label = SKLabelNode(text: "Пропустить")
        button.name = "skip-label"
        label.position = CGPoint(x: displayWidth! / 2.2 + 6, y: displayHeight! / 2 + 4)
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
                showLevel1Scene()
                self.releaseSpeechTimers()
            }
         
        }
    }

    func showLevel1Scene() {
        print("show")
        let level1Scene = SKScene(fileNamed: "Level1Scene")
        let transition = SKTransition.fade(with: .black, duration: 1.0)
        level1Scene?.scaleMode = .aspectFill
        self.view?.presentScene(level1Scene!, transition: transition)
    }
    
    deinit {
        print("scene Intro did deallocate")
    }
}
