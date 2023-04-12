//
//  GamePlayFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// General Game Functions
extension ParkingWorkGame {
    
    func showCarOpenedSuccessMessage(of targetCar: Car) {
        let carName = targetCar.name
        
        openCarSuccessWindow?.position = CGPoint(x: (cameraNode?.frame.midX)!, y: (cameraNode?.frame.midY)!)
        openCarSuccessWindowGarageLabel?.text = "\(carName) появится в вашем гараже"
        openCarSuccessWindow?.alpha = 1
        
    }
    
    func hideCarOpenedSuccessMessage() {
        if openCarSuccessWindow?.alpha == 0 { return }
        openCarSuccessWindow?.alpha = 0
    }
    
    // this creates window text and buttons for open car message pop-up
    func createOpenCarMessage() {

        // window itself
        let window = SKShapeNode(rectOf: CGSize(width: 260, height: 40), cornerRadius: 10.0)
        
        // hide it initially
        window.alpha = 0
        window.zPosition = 11
        
        window.fillColor = UIColor(named: Colors.OpenCarWindowColor.rawValue)!
        window.strokeColor = UIColor(named: Colors.OpenCarWindowColorStroke.rawValue)!
        window.name = "ui-openCarMessageWindow"
        
        window.position = CGPoint(x: 0, y: -((displayHeight! / 2) - 28))
        self.cameraNode!.addChild(window)
        
        // - message label set to 'Попробовать вскрыть?' initially
        let messageLabel = SKLabelNode(text: "Попробовать вскрыть?")
        messageLabel.name = "ui-carMessage"
        messageLabel.position = CGPoint(x: -30, y: 0)
        messageLabel.verticalAlignmentMode = .center
        messageLabel.fontName = "Copperplate"
        messageLabel.fontSize = 16
        messageLabel.fontColor = UIColor(named: Colors.OpenCarWindowCarMsgColor.rawValue)
        
        window.addChild(messageLabel)
        
        //  open car button
        let yesBtn = SKShapeNode(rect: CGRect(x: (window.frame.width / 2) - 64, y: -15, width: 56, height: 28), cornerRadius: 6.0)
        yesBtn.fillColor = UIColor(named: Colors.OpenCarYesBtnColor.rawValue)!
        yesBtn.strokeColor = UIColor(named: Colors.OpenCarYesBtnColor.rawValue)!
        yesBtn.name = "ui-yesOpenLockBtn"
        window.addChild(yesBtn)
        
        let yesBtnLabel = SKLabelNode(text: "Да")
        yesBtnLabel.name = "ui-yesBtnLabel"
        yesBtnLabel.fontName = "Copperplate"
        yesBtnLabel.fontSize = 20
        yesBtnLabel.verticalAlignmentMode = .center
        yesBtnLabel.horizontalAlignmentMode = .center
        yesBtnLabel.position = CGPoint(x: ((window.frame.width / 2) - 66) + (yesBtn.frame.width / 2), y: 0)
        
        yesBtn.addChild(yesBtnLabel)
        
        openCarWindow = window
    }
    
    /// Shows pop-up window, offering to try to open the lock when player comes сlose to it.
    func showOpenCarMessage(of targetCar: Car, lockType: String) {
        if openCarWindow?.alpha != 0 { return }
        openCarWindow?.alpha = 1
    }
    
    /// Hides pop-up window, that offering to open car lock.
    func hideOpenCarMessage() {
        openCarWindow?.alpha = 0
        canGoFromDoor = false
    }
    
    func showTargetSquare(of targetCar: Car, lockType: String) {
        
        // add one zero at the end if complexity 0.1 to display -> 0.10
        let complexity = "\(targetCar.locks[lockType]!!)".count == 3 ? "\(targetCar.locks[lockType]!!)0" : "\(targetCar.locks[lockType]!!)"
        
        let carNameLabel = self.targetSquare?.childNode(withName: "car-name") as? SKLabelNode
        let lockTypeLabel = self.targetSquare?.childNode(withName: "lockTypeLabel") as? SKLabelNode
        let complexityLabel = self.targetSquare?.childNode(withName: "complexity-label") as? SKLabelNode
        let complexityNum = complexityLabel?.childNode(withName: "complexityNumLevel") as? SKLabelNode
        
        carNameLabel?.text = "\(targetCar.name)"
        
        lockTypeLabel?.text = "\(LOCK_TRANSLATIONS[lockType] ?? "тип неизвестен")"
        complexityNum?.text = "\(complexity)/100.00"
        
        self.targetSquare?.alpha = 0.8
    }
    
    func hideTargetSquare() {
        self.targetSquare?.alpha = 0
    }
    
    func checkDistanceBetweenPlayerAndTargetLock() {
 
        let playerPosition = player?.node?.position
        let targetLockPosition = player?.currLockTarget?.parent?.position

        let diffX = abs(playerPosition!.x) - abs(targetLockPosition!.x)
        let diffY = abs(playerPosition!.y) - abs(targetLockPosition!.y)

        if (abs(diffX) > 150 || abs(diffY) > 150) {
            hideOpenCarMessage()
        }
        // lock target clearing
        if ( abs(diffX) > 420 || abs(diffY) > 420) {
            player?.currLockTarget = nil
            player!.currTargetCar = nil
            hideTargetSquare()
        }
    
    }
    
    // this creates window text and buttons for open car success message pop-up
    func createOpenCarSuccessMessage() {
        // window itself
        let window = SKShapeNode(rectOf: CGSize(width: 500, height: 300), cornerRadius: 10.0)
        window.alpha = 0
        window.zPosition = 12 // player=10, suggestpopUp=11 + 1
        
        window.position = player!.node!.position
        
        window.fillColor = UIColor(named: Colors.OpenCarSuccessWindowColor.rawValue)!
        window.strokeColor = UIColor(named: Colors.OpenCarSuccessWindowColor.rawValue)!
        window.name = "openCarSuccessWindow"
        
        self.addChild(window)
        
        // success label
        let successLabel = SKLabelNode(text: "Вскрытие успешно!")
        successLabel.name = "successLabel"
        successLabel.fontSize = 32
        successLabel.fontName = "American Typewriter Semibold"
        successLabel.fontColor = UIColor(named: Colors.OpenCarSuccessWindowSuccessLabelColor.rawValue)
        successLabel.position = CGPoint(x: 0, y: 80)
        window.addChild(successLabel)
        
        // car will go to garage label
        let toGarageLabel = SKLabelNode(text: "Old Copper появится в вашем гараже.")
        toGarageLabel.fontName = "American Typewriter Semibold"
        toGarageLabel.fontSize = 24
        toGarageLabel.fontColor = UIColor(named: Colors.OpenCarSuccessWindowGarageLabelColor.rawValue)
        toGarageLabel.position = CGPoint(x: 0, y: 0)
        toGarageLabel.name = "garageLabel"
        
        window.addChild(toGarageLabel)
        
        // good button window
        let goodBtn = SKShapeNode(rect: CGRect(x: -75, y: -100, width: 150, height: 40), cornerRadius: 6)
        goodBtn.name = "goodButton"
        goodBtn.fillColor = .gray
        goodBtn.strokeColor = .gray
        
        window.addChild(goodBtn)
        
        // good button label
        let goodBtnLabel = SKLabelNode(text: "Хорошо")
        goodBtnLabel.position = CGPoint(x: 0, y: -88)
        goodBtnLabel.fontColor = .black
        goodBtnLabel.alpha = 0.75
        
        goodBtnLabel.fontName = "American Typewriter Bold"
        goodBtnLabel.fontSize = 24
        goodBtnLabel.name = "goodLabel"
        
        goodBtn.addChild(goodBtnLabel)
    }
    
    func blinkLightSignals(of car: Car) {
        
        let lightSignals = car.node?.childNode(withName: "light_signals")
        
        let signalingCar = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(blinkLights), userInfo: lightSignals, repeats: true)
        
        // stop signal after 15 seconds
        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
            signalingCar.invalidate()
            self.removeAction(forKey: (car.node?.name)! + "_light_signal")
            car.signaling = false
        }
       
    }
    
    @objc func blinkLights(sender: Timer) {
        let lightSignals = sender.userInfo as? SKNode
        if lightSignals?.alpha == 0  {
            lightSignals?.alpha = 1
        } else {
            lightSignals?.alpha = 0
        }
        
    }
    
    // create anxiety bar
    func createAnxietyBar() {
        
        let cropShape = SKCropNode()
        cropShape.zPosition = 15
        cropShape.position = CGPoint(x: -(displayWidth! / 2) + 100, y: -(displayHeight! / 2) + 20)
        
        // shape for stroke
        let outerShape = SKShapeNode(rectOf: CGSize(width: 140, height: 17), cornerRadius: 6)
        outerShape.zPosition = 15
        outerShape.strokeColor = .white
        outerShape.lineWidth = 2
        
        outerShape.position = CGPoint(x: -(displayWidth! / 2) + 100, y: -(displayHeight! / 2) + 20)

        let maskShape = SKShapeNode(rectOf: CGSize(width: 140, height: 17), cornerRadius: 8)
        maskShape.fillColor = .black
        cropShape.maskNode = maskShape
        
        let innerSprite = SKSpriteNode(color: .blue, size: CGSize(width: 0, height: 20) )
        innerSprite.anchorPoint = CGPoint(x: 0, y: 0)
        
        innerSprite.position = CGPoint(x: -(maskShape.frame.width / 2), y: -(maskShape.frame.height / 2) )
            
        anxietyOuterShape = outerShape
        anxietyInnerSprite = innerSprite
        
        cropShape.addChild(innerSprite)
        self.cameraNode?.addChild(cropShape)
        self.cameraNode?.addChild(outerShape)
        
        // set for global access
        self.anxietyBar = innerSprite
        
    }
    
    
    // rising anxiety bar (144max)
    func raiseAnxiety(to num: CGFloat) {
        // do not raise anxiety during showing tutorial messages
        if canMoveCamera == false { return }
        
        canReduceAnxiety = false
        
        let futureWidth = anxietyLevel + num
        
        if futureWidth > 144.0 {
            anxietyLevel = 144
        } else {
            anxietyLevel = futureWidth
        }
        anxietyBar!.run(SKAction.resize(toWidth: anxietyLevel, duration: 0.2)) {
            self.canReduceAnxiety = true
        }
 
    }
    
    // blinks anxiety bar
    func hightLightAnxietyBar() {
        if self.anxietyLevel >= 110.0 {
            self.anxietyOuterShape?.strokeColor = Colors.DangerStrokeRed
            self.anxietyInnerSprite?.color = .black
            
            if !animatedAnxietyFirst {
                animatedAnxietyFirst = true
                self.anxietyOuterShape?.run(SKAction.scale(to: 1.2, duration: 0.2), completion: {
                    self.anxietyOuterShape?.setScale(1.0)
                })
            }
            
        } else if self.anxietyLevel > 70.0 && self.anxietyLevel <= 110.0 {
            if !animatedAnxietySecond {
                self.animatedAnxietySecond = true
                self.anxietyOuterShape?.run(SKAction.scale(to: 1.2, duration: 0.2), completion: {
                    self.anxietyOuterShape?.setScale(1.0)
                })
            }

            self.anxietyOuterShape?.strokeColor = .white
            self.anxietyInnerSprite?.color = .blue
        } else {
            self.animatedAnxietyFirst = false
            self.animatedAnxietySecond = false
            self.anxietyOuterShape?.strokeColor = .white
            self.anxietyInnerSprite?.color = .systemBlue
        }
    }
    
    // reduce anxiety
    func reduceAnxiety(to num: CGFloat) {
        canReduceAnxiety = false
        
        let futureWidth = anxietyLevel - num
        
        if futureWidth < 0 {
            anxietyLevel = 0
        } else {
            anxietyLevel = futureWidth
        }
        anxietyBar!.run(SKAction.resize(toWidth: anxietyLevel, duration: 0.2)) {
            self.canReduceAnxiety = true
        }
 
    }
    
    // Zooming Out
    func zoomOutCamera(to num: CGFloat) {
        
        let act = SKAction.scale(by: num, duration: 2.0)
        let act2 = SKAction.sequence([act, SKAction.wait(forDuration: 1.5)])
        cameraNode?.run(act2, completion: {
            self.cameraNode?.run(SKAction.scale(to: self.minScale, duration: 0.7), completion: {
//                self.startTutorial()
            })
        })

        
    }
    
    // showing level number message at the center of the screens
    func showLevelNumLabel() {
        let levelNumberNode = self.cameraNode?.childNode(withName: "LevelNumberNode")
        let levelLabelNode = levelNumberNode?.childNode(withName: "LevelLabelNode") as? SKLabelNode
        levelLabelNode?.run(SKAction.fadeIn(withDuration: 0.8))
        
        levelLabelNode?.text = "Уровень \(levelNum)"
        let act = SKAction.resize(toWidth: displayWidth!, duration: 0.3)
        levelNumberNode?.run(act)
        
        levelLabelNode?.run(SKAction.scale(to: 1.2, duration: 0.4), completion: {
            levelLabelNode?.run(SKAction.scale(to: 1.0, duration: 0.15))
            // roll back and hide
            Timer.scheduledTimer(withTimeInterval: 2.2, repeats: false) { _ in
                let act = SKAction.resize(toWidth: 0, duration: 0.6)
                levelNumberNode?.run(act)
                levelLabelNode?.run(SKAction.fadeOut(withDuration: 0.5))

                levelLabelNode?.run(SKAction.scale(to: 1.2, duration: 0.2))
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    levelLabelNode?.run(SKAction.scale(to: 1.0, duration: 0.15))
                }
            }
        })
    }
    
    func showStartLabel() {
        let levelNumberNode = self.cameraNode?.childNode(withName: "LevelNumberNode")
        let levelLabelNode = levelNumberNode?.childNode(withName: "LevelLabelNode") as? SKLabelNode
        levelLabelNode?.run(SKAction.fadeIn(withDuration: 0.8))
        
        levelLabelNode?.text = "Игра начинается"
        let act = SKAction.resize(toWidth: displayWidth!, duration: 0.3)
        levelNumberNode?.run(act)
        
        levelLabelNode?.run(SKAction.scale(to: 1.2, duration: 0.4), completion: {
            levelLabelNode?.run(SKAction.scale(to: 1.0, duration: 0.15))
            // roll back and hide
            Timer.scheduledTimer(withTimeInterval: 2.2, repeats: false) { _ in
                let act = SKAction.resize(toWidth: 0, duration: 0.6)
                levelNumberNode?.run(act)
                levelLabelNode?.run(SKAction.fadeOut(withDuration: 0.5))

                levelLabelNode?.run(SKAction.scale(to: 1.2, duration: 0.2))
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    levelLabelNode?.run(SKAction.scale(to: 1.0, duration: 0.15))
                }
            }
        })
    }
   
    
    func createMinimap() {
            
        let mapWidth: CGFloat = 120
        let mapHeight: CGFloat = 100
        
        let mapPos = CGPoint(x: -displayWidth! / 2 + 70, y: displayHeight! / 2 - 70)
        
        let cropNode = SKCropNode()
        
        cropNode.zPosition = 20
        cropNode.position = mapPos
        
//        let mask = SKShapeNode(rect: CGRect(x: -mapWidth / 2, y: -mapHeight / 2, width: mapWidth, height: mapHeight), cornerRadius: 10)
        let mask = SKShapeNode(circleOfRadius: 60)
        
        mask.fillColor = UIColor.white
        mask.alpha = 0.8

        cropNode.maskNode = mask
        
        // border around minimap
//        let strokeShape = SKShapeNode(rect: CGRect(x: -mapWidth / 2, y: -mapHeight / 2, width: mapWidth, height: mapHeight), cornerRadius: 10)
        let strokeShape = SKShapeNode(circleOfRadius: 60)
        strokeShape.name = "mini-map-stroke"
        strokeShape.position = mapPos
        strokeShape.zPosition = 20
        strokeShape.lineWidth = 2
        strokeShape.alpha = 0.7
        strokeShape.strokeColor = UIColor.black


        // set mini map level sprite
        miniMapSprite = SKSpriteNode(texture: SKTexture(image: UIImage(named: "minimap")!))
        miniMapSprite?.size.width = mapWidth
        miniMapSprite?.size.height = mapHeight
        
        miniMapWidth = miniMapSprite?.frame.width
        miniMapHeight = miniMapSprite?.frame.height

        cropNode.addChild(miniMapSprite!)
        miniMapSprite?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        miniMapSprite?.zPosition = 0
        
        self.cameraNode?.addChild(cropNode)
        self.cameraNode?.addChild(strokeShape)
        
        // plus minus buttons
//        let plusBtn = SKLabelNode(text: "+")
//        plusBtn.zPosition = 20
//        let minusBtn = SKLabelNode(text: "-")
//        minusBtn.zPosition = 20
//
//        plusBtn.fontSize = 20
//        minusBtn.fontSize = 20
//
//        plusBtn.position = CGPoint(x: -displayWidth! / 2 + 100 + 20, y: (displayHeight! / 2) - 80 - (miniMapHeight! / 2 + 25))
//
//        minusBtn.position = CGPoint(x: (-displayWidth! / 2 ) + 100 - 20, y: (displayHeight! / 2) - 80 - (miniMapHeight! / 2 + 25))
//        self.cameraNode?.addChild(plusBtn)
//        self.cameraNode?.addChild(minusBtn)
        
        // add player dot to mini map
        self.miniMapPlayerDot = SKShapeNode(circleOfRadius: 3)
        miniMapPlayerDot!.fillColor = .orange
        cropNode.addChild(miniMapPlayerDot!)
        
        self.miniMapSprite?.setScale(miniMapScaleFactor)
        // set crop node globally for adding car dots on Level init class
        self.miniMapCropNode = cropNode
        self.miniMapCropNode?.zPosition = 2
        

    

    }

    
    // this updates position of the player on minimap
    func updateMiniMapPlayerPos() {
    
        let scaleWidthFactor = tileMapWidth! / miniMapWidth!
        let scaleHeightFactor = tileMapHeight! / miniMapHeight!

        let miniMapX = player!.node!.position.x / scaleWidthFactor * miniMapScaleFactor
        let minimapY = player!.node!.position.y / scaleHeightFactor * miniMapScaleFactor
        
        miniMapSprite?.position = CGPoint(x: -miniMapX, y: -minimapY)
    }
    
    
    
    // creates screen with task for a level message
    func createLevelTaskScreen() {

        // background
        taskScreen = SKSpriteNode(color: .black, size: CGSize(width: displayWidth!, height: displayHeight!))
        
        cameraNode?.addChild(taskScreen!)
        taskScreen?.position = CGPoint(x: 0, y: 0)
        taskScreen?.zPosition = 45
        taskScreen?.alpha = 0
        
        // close task screen button
        let closeTaskScreenBtn = SKShapeNode(circleOfRadius: 14)
        closeTaskScreenBtn.name = "ui-closeTaskBtn"
        closeTaskScreenBtn.fillColor = UIColor.gray
        closeTaskScreenBtn.alpha = 0.75
        closeTaskScreenBtn.position = CGPoint(x: -displayWidth! / 2 + 150, y: displayHeight! / 2 - 26)
        closeTaskScreenBtn.zPosition = 50
        
        // close task screen label
        let closeTaskScreenLabel = SKLabelNode(text: "X")
        closeTaskScreenLabel.name = "ui-closeTaskLabel"
        closeTaskScreenLabel.fontSize = 20
        closeTaskScreenLabel.fontName = "Baskerville-bold"
        closeTaskScreenLabel.fontColor = .white
        closeTaskScreenLabel.horizontalAlignmentMode = .center
        closeTaskScreenLabel.verticalAlignmentMode = .center
        
        closeTaskScreenBtn.addChild(closeTaskScreenLabel)
        
        taskScreen?.addChild(closeTaskScreenBtn)
        
        // level number label
        let levelNum = SKLabelNode(text: "Уровень \(levelNum)")
        levelNum.fontSize = 30
        levelNum.fontName = "Baskerville-bold"
        levelNum.position = CGPoint(x: 70, y: displayHeight! / 2 - 40)
        taskScreen?.addChild(levelNum)
        
        // level task message
        let spriteRect = SKSpriteNode()
//        spriteRect.size = CGSize(width: displayWidth! - 260, height: 100)
        spriteRect.color = UIColor(named: Colors.TaskMessageBackground.rawValue)!
        spriteRect.alpha = 0.9
        spriteRect.position = CGPoint(x: 70, y: displayHeight! / 2 - 130)
        
        let taskMessage = SKLabelNode(text: "Босс: \(UNICODE.leftChevrone)Марка машины мне не важна, на твое усмотрение. Главное,  доставь её к нам без полиции на хвосте, так чтобы мы убедились в твоих намерениях.\(UNICODE.rightChevrone)")
        taskMessage.fontSize = 24
        taskMessage.fontName = FONTS.Baskerville
        taskMessage.fontColor = UIColor.white
        taskMessage.preferredMaxLayoutWidth = displayWidth! - 240
        taskMessage.numberOfLines = 0
        taskMessage.horizontalAlignmentMode = .center
        taskMessage.verticalAlignmentMode = .center
        spriteRect.addChild(taskMessage)
        taskScreen?.addChild(spriteRect)
        
        spriteRect.size = CGSize(width: displayWidth! - 230, height: taskMessage.frame.height)
        
        let bossSiluette = SKSpriteNode(texture: SKTexture(imageNamed: "boss-siluette"))
        bossSiluette.setScale(0.48)
        bossSiluette.position = CGPoint(x: displayWidth! / 2 - 100, y: -displayHeight! / 2 + 20)
        taskScreen?.addChild(bossSiluette)
        
    }
    
    func showTaskScreen() {
        taskScreen?.run(SKAction.fadeAlpha(to: 0.9, duration: 0.2), completion: {
            self.isPaused = true
        })
        miniMapCropNode?.zPosition = 45

    }
    
    func hideTaskScreen() {
        taskScreen?.alpha = 0
        self.isPaused = false
        self.miniMapCropNode?.zPosition = 2
    }
    
    func showMenuScreen() {
        menuScreen?.run(SKAction.fadeAlpha(to: 1.0, duration: 0.2), completion: {
            self.isPaused = true
        })
    }
    
    func hideMenuScreen() {
        menuScreen?.alpha = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            self.isPaused = false
        }
    }
    
    func showSettingsScreen() {
        print("show settings!")
//        settingsScreen?.run(SKAction.fadeAlpha(to: 0.9, duration: 0.2), completion: {
//            self.isPaused = true
//        })
    }
    
    func hideSettingsScreen() {
        settingsScreen?.alpha = 0
    }
    
    
    // creates menu screen to pause game and settings
    func createMenuScreen() {
        // background
        menuScreen = SKSpriteNode(texture: SKTexture(imageNamed: "MenuBackground"), size: CGSize(width: displayWidth!, height: displayHeight!))
        

        cameraNode?.addChild(menuScreen!)
        menuScreen?.position = CGPoint(x: 0, y: 0)
        menuScreen?.zPosition = 52
        menuScreen?.alpha = 0
        
        // resume game button
        let resumeGameBtn = SKShapeNode(rectOf: CGSize(width: 200, height: 40))
        let yPos = resumeGameBtn.frame.height
        resumeGameBtn.position = CGPoint(x: 0, y: yPos)
        resumeGameBtn.name = "ui-resumeGameBtn"
        resumeGameBtn.fillColor = Colors.MenuButtonsColor

        // resume game button label
        let resumeGameBtnLabel = SKLabelNode(text: "Продолжить")
        resumeGameBtnLabel.name = "ui-resumeGameBtnLabel"
        resumeGameBtnLabel.fontSize = 20
        resumeGameBtnLabel.fontName = "Baskerville-bold"
        resumeGameBtnLabel.fontColor = .white
        resumeGameBtnLabel.horizontalAlignmentMode = .center
        resumeGameBtnLabel.verticalAlignmentMode = .center

        resumeGameBtn.addChild(resumeGameBtnLabel)

        menuScreen?.addChild(resumeGameBtn)
        
        // level number label
        let levelNum = SKLabelNode(text: "Уровень \(levelNum)")
        levelNum.fontSize = 30
        levelNum.fontName = "Baskerville-bold"
        levelNum.position = CGPoint(x: 0, y: yPos * 2)
        menuScreen?.addChild(levelNum)
        
        // settings game button
        let settingsGameBtn = SKShapeNode(rectOf: CGSize(width: 200, height: 40))
        settingsGameBtn.position = CGPoint(x: 0, y: yPos - yPos - 2 )
        settingsGameBtn.name = "ui-gameSettingsBtn"
        settingsGameBtn.fillColor = Colors.MenuButtonsColor

        // settings game button label
        let settingsGameBtnLabel = SKLabelNode(text: "Настройки")
        settingsGameBtnLabel.name = "ui-gameSettingsBtnLabel"
        settingsGameBtnLabel.fontSize = 20
        settingsGameBtnLabel.fontName = "Baskerville-bold"
        settingsGameBtnLabel.fontColor = .white
        settingsGameBtnLabel.horizontalAlignmentMode = .center
        settingsGameBtnLabel.verticalAlignmentMode = .center

        settingsGameBtn.addChild(settingsGameBtnLabel)

        menuScreen?.addChild(settingsGameBtn)
        
        // game name label
        let gameName = SKLabelNode(text: "Parking Work")
        gameName.fontSize = 54
        gameName.fontName = "Chalkduster"
        gameName.fontColor = Colors.GameNameLabelColor
        gameName.position = CGPoint(x: 0, y: displayHeight! / 2 - 55)
        menuScreen?.addChild(gameName)
    }
    
    // creates buttons
    func createUIButtons() {
 
        // task button
        let taskBtn = SKShapeNode(circleOfRadius: 14)
        taskBtn.name = "ui-taskBtn"
        taskBtn.fillColor = UIColor.gray
        taskBtn.alpha = 0.75
        taskBtn.zPosition = 51
        taskBtn.position = CGPoint(x: -displayWidth! / 2 + 150, y: displayHeight! / 2 - 26)
        self.taskButton = taskBtn
        
        //  task button label
        let taskBtnLabel = SKLabelNode(text: "?")
        taskBtnLabel.name = "ui-taskLabel"
        taskBtnLabel.fontSize = 20
        taskBtnLabel.fontName = "Baskerville-bold"
        taskBtnLabel.fontColor = .white
        taskBtnLabel.horizontalAlignmentMode = .center
        taskBtnLabel.verticalAlignmentMode = .center
        
        taskBtn.addChild(taskBtnLabel)
        
        self.cameraNode?.addChild(taskBtn)
        
        // menu button
        let menuBtn = SKShapeNode(rectOf: CGSize(width: 30, height: 30), cornerRadius: 6)
        menuBtn.name = "ui-menuBtn"
        menuBtn.fillColor = UIColor.gray
        menuBtn.alpha = 0.75
        menuBtn.zPosition = 10
        menuBtn.position = CGPoint(x: displayWidth! / 2 - 40, y: displayHeight! / 2 - 26)
        
        self.menuButton = menuBtn
        
        // menu button label
        let menuBtnLabel = SKLabelNode(text: "\u{23F8}")
        menuBtnLabel.name = "ui-menuLabel"
        menuBtnLabel.fontSize = 32
        menuBtnLabel.fontName = "Baskerville-bold"
        menuBtnLabel.fontColor = .white
        menuBtnLabel.horizontalAlignmentMode = .center
        menuBtnLabel.verticalAlignmentMode = .center
        
        menuBtn.addChild(menuBtnLabel)
        
        self.cameraNode?.addChild(menuBtn)
        
        // run button
        let runBtn = SKShapeNode(circleOfRadius: 38)
        self.runButton = runBtn
        runBtn.name = "ui-runBtn"
        runBtn.fillColor = UIColor.brown
        runBtn.alpha = 0.75
        runBtn.zPosition = 10
        runBtn.position = CGPoint(x: (displayWidth! / 2) - 90, y: -(displayHeight! / 2) + 90)
        
        let shoe = SKSpriteNode(texture: SKTexture(imageNamed: "shoe"))
        shoe.name = "ui-runBtnImg"
        shoe.size.width = 50
        shoe.size.height = 50
        
        runBtn.addChild(shoe)
        
        self.cameraNode?.addChild(runBtn)
    }
    
    
    func createSelectedTarget() {
        
        // square itself
        targetSquare = SKShapeNode(rectOf: CGSize(width: 210, height: 66))
        targetSquare?.fillColor = SKColor.black
        targetSquare?.position = CGPoint(x: 0, y: displayHeight! / 2 - 38)
        // set z position
        targetSquare?.zPosition = 11
        
        self.cameraNode?.addChild(targetSquare!)
        
        // target's car name label
        let carLabel = SKLabelNode(text: "Some Car")
        carLabel.name = "car-name"
        carLabel.horizontalAlignmentMode = .center
        carLabel.verticalAlignmentMode = .center
        carLabel.fontSize = 20
        carLabel.fontName = "\(FONTS.Baskerville)-bold"
        carLabel.verticalAlignmentMode = .top
        carLabel.position = CGPoint(x: 0, y: (targetSquare?.frame.height)! / 2 - 6)
        targetSquare?.addChild(carLabel)
        
        // target's car lock complexity
        // - lock type label
        let lockTypeLabel = SKLabelNode(text: "")
        lockTypeLabel.name = "lockTypeLabel"
        lockTypeLabel.text = "Пассажирский замок"
        lockTypeLabel.fontName = "Hoefler Text"
        lockTypeLabel.fontSize = 18
        lockTypeLabel.fontColor = UIColor(named: Colors.OpenCarWindowLockTypeColor.rawValue)
        lockTypeLabel.verticalAlignmentMode = .top
        lockTypeLabel.position = CGPoint(x: 0, y: (targetSquare?.frame.height)! / 2 - 24)
        
        targetSquare?.addChild(lockTypeLabel)
        
        // complexity level label
        let complexityLabel = SKLabelNode(text: "Cложность:")
        complexityLabel.name = "complexity-label"
        complexityLabel.fontName = "Hoefler Text"
        complexityLabel.fontSize = 18
        complexityLabel.fontColor = UIColor(named: Colors.OpenCarWindowComplexityColor.rawValue)
        complexityLabel.verticalAlignmentMode = .top
        complexityLabel.position = CGPoint(x: -50, y: ((targetSquare?.frame.height)! / 2) - 45)
        
        targetSquare?.addChild(complexityLabel)
        
        // complexity level number
        let complexityNumLabel = SKLabelNode(text: "0.08/1.00")
        complexityNumLabel.name = "complexityNumLevel"
        complexityNumLabel.fontName = "Hoefler Text"
        complexityNumLabel.fontSize = 18
        complexityNumLabel.fontColor = UIColor(named: Colors.OpenCarLockComplexityLightColor.rawValue)
        complexityNumLabel.verticalAlignmentMode = .top
        complexityNumLabel.position = CGPoint(x: 100, y: 0)
    
        complexityLabel.addChild(complexityNumLabel)
        
        // hidden initially
        hideTargetSquare()
        
    }
    
    func showCarLocksTutorial(tutorialMsg: Int) {
        print(tutorialMsg)
        self.canMoveCamera = false

        let messageLabel = self.tutorialWindow?.childNode(withName: "msg-label") as? SKLabelNode
        let nextBtn = self.tutorialWindow?.childNode(withName: "ui-next-btn") as? SKShapeNode
        let nextBtnLabel = nextBtn?.childNode(withName: "ui-next-label-btn") as? SKLabelNode
        
        self.tutorialWindow?.alpha = 1
        
        if tutorialMsg == 25 {
            messageLabel?.text = "При вскрытии машин, обращайте внимание на  \(UNICODE.leftChevrone)Тип замка\(UNICODE.rightChevrone) и \(UNICODE.leftChevrone)Сложность\(UNICODE.rightChevrone), они показываются в верхней части экрана, когда вы подходите к замку двери."
            nextBtnLabel?.text = "Далее"
        } else if tutorialMsg == 26 {
            messageLabel?.text = "Сложность может варьироваться от 0 до 100, где 0 - это легкий взлом, а 100 - самый сложный. Успех взлома напрямую зависит от сложности замка и вашего умения взлома."
        }
        else if tutorialMsg == 27 {
            messageLabel?.text = "Более легкая сложность будет отмечена зеленым, а более сложная - синим или еще хуже - красным цветом. Обращайте на это внимание, провальный взлом производит много шума!"
        }
        else if tutorialMsg == 28 {
            messageLabel?.text = "По мере прохождения игры, вы сможете увеличивать свое умение взлома и взламывать более сложные замки."
            nextBtnLabel?.text = "Понятно"
        } else if tutorialMsg == 29 {
            self.tutorialWindow?.alpha = 0
            canMoveCamera = true
        }
    }
    
}

