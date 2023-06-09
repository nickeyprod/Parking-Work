//
//  TutorialSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 10.04.2023.
//

import SpriteKit

// General Game Functions
extension Mission1 {
    // Creates tutorial window with messages in it
    func createTutorial() {
        let tutorialWindow = SKShapeNode(rectOf: CGSize(width: displayWidth! / 2, height: displayHeight! / 2))
        tutorialWindow.fillColor = .black
        tutorialWindow.alpha = 0.8
        tutorialWindow.strokeColor = .gray
        tutorialWindow.zPosition = 11
        tutorialWindow.position = CGPoint(x: 0, y: 0)
        self.cameraNode?.addChild(tutorialWindow)
        
        let messageLabel = SKLabelNode(text: "Это небольшое обучение, сейчас вы попробуете вскрыть свою первую машину.")
        messageLabel.name = "msg-label"
        messageLabel.fontName = FONTS.Baskerville
        messageLabel.preferredMaxLayoutWidth = tutorialWindow.frame.width - 26
        messageLabel.numberOfLines = 0
        messageLabel.fontSize = 20
        messageLabel.horizontalAlignmentMode = .center
        messageLabel.verticalAlignmentMode = .top
        messageLabel.position = CGPoint(x: 0, y: tutorialWindow.frame.height / 2 - 16)
        
        tutorialWindow.addChild(messageLabel)
        
        let nextBtn = SKShapeNode(rectOf: CGSize(width: 60, height: 25), cornerRadius: 8)
        nextBtn.name = "ui-next-btn"
        nextBtn.fillColor = .gray
        nextBtn.position = CGPoint(x: (tutorialWindow.frame.width / 2) - 40, y: -(tutorialWindow.frame.height / 2) + 25 )
        tutorialWindow.addChild(nextBtn)
        
        let nextLabel = SKLabelNode(text: "Далее")
        nextLabel.name = "ui-next-label-btn"
        nextLabel.fontName = FONTS.Baskerville
        nextLabel.fontSize = 14
        nextLabel.verticalAlignmentMode = .center
        nextBtn.addChild(nextLabel)
        
        self.tutorialWindow = tutorialWindow
    }
    
    // Shows next tutorial message
    func nextTutorialMsg() {
        self.tutorialWindow?.alpha = 0
        
        let messageLabel = self.tutorialWindow?.childNode(withName: "msg-label") as? SKLabelNode
        let nextBtn = self.tutorialWindow?.childNode(withName: "ui-next-btn") as? SKShapeNode
        let nextBtnLabel = nextBtn?.childNode(withName: "ui-next-label-btn") as? SKLabelNode
        
        let oldCopper = carsOnLevel[0]
        let moveAct = SKAction.move(to: (oldCopper?.node?.position)!, duration: 2.0)
        if tutorialMsg == 1 {
            self.cameraNode?.run(moveAct, completion: {
                messageLabel?.text = "Чтобы попытаться вскрыть машину, подойдите к дверям, обозначенным красным цветом."
                self.tutorialWindow?.alpha = 1
                self.tutorialMsg += 1
            })
        }
        else if tutorialMsg == 2 {
            let driverLock = oldCopper?.node?.childNode(withName: "driver_lock")
            let passengerLock = oldCopper?.node?.childNode(withName: "passenger_lock")
            
            driverLock?.run(SKAction.scale(to: 3.4, duration: 1.0), completion: {
                driverLock?.run(SKAction.scale(to: 1.0, duration: 0.4))
                passengerLock?.run(SKAction.scale(to: 3.4, duration: 1.0), completion: {
                    passengerLock?.run(SKAction.scale(to: 1.0, duration: 0.4), completion: {
                        self.tutorialMsg += 1
                        self.nextTutorialMsg()
                    })
                })
            })
        }
        else if tutorialMsg == 3 {
            messageLabel?.text = "Двери, отмеченные красным, означают что их можно попробовать вскрыть, такие отметки могут быть не у каждой машины, так что обращайте на них внимание."
            self.tutorialWindow?.alpha = 1
            tutorialMsg += 1
        }
        else if tutorialMsg == 4 {
            messageLabel?.text = "После того как вы подойдете к двери, нажмите \(UNICODE.leftChevrone)Да\(UNICODE.rightChevrone) во всплывающем окне для попытки взлома."
            self.tutorialWindow?.alpha = 1
            tutorialMsg += 1
        }
        else if (tutorialMsg == 5) {
            messageLabel?.text = "Если вы будете нацелены на взлом и будете долго находиться возле машины, люди начнут вас подозревать, начнёт расти шкала тревожности в левом нижнем углу!"
            self.tutorialWindow?.alpha = 1
            tutorialMsg += 1
        }
        else if (tutorialMsg == 6) {
            self.anxietyOuterShape?.run(SKAction.scale(to: 1.4, duration: 0.8), completion: {
                self.anxietyOuterShape?.run(SKAction.scale(to: 1.0, duration: 0.5)) {
                    self.tutorialMsg += 1
                    self.nextTutorialMsg()
                }
            })
            
        }
        else if (tutorialMsg == 7) {
            messageLabel?.text = "Как только шкала достигнет максимума, прохожие вызовут полицию, тогда вас заберут в участок и игра будет окончена."
            self.tutorialMsg += 1
            self.tutorialWindow?.alpha = 1
            nextBtnLabel?.text = "Хорошо"
        }
        else if (tutorialMsg == 8) {
            self.tutorialWindow?.alpha = 1
          
            messageLabel?.text = "Когда шкала почти заполнилась, чтобы вас не заподозрили во взломе, как можно скорей отойдите подальше от взламываемой машины, так тревожность начнет спадать."
        
            self.tutorialMsg += 1
            
            nextBtnLabel?.text = "Далее"
        }
        else if (tutorialMsg == 9) {
            self.tutorialWindow?.alpha = 0
            self.cameraNode?.run(SKAction.move(to: (player?.node?.position)!, duration: 2.0), completion: {
                self.tutorialWindow?.alpha = 1
                messageLabel?.text = "Чтобы передвигаться, просто нажмите в любое место на экране, там будет размещена цель, игрок начнет движение к месту касания."
            })
            self.tutorialMsg += 1
            
            
            nextBtnLabel?.text = "Показать"
        }
        else if (tutorialMsg == 10) {
            self.tutorialWindow?.alpha = 0
        
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
                
                let tapCircle = SKShapeNode(circleOfRadius: 20)
                tapCircle.fillColor = .gray
                tapCircle.position = CGPoint(x: (self.player?.node?.position.x)! - 250, y: (self.player?.node?.position.y)!)
                tapCircle.zPosition = 11
                self.addChild(tapCircle)
                
                tapCircle.run(SKAction.scale(to: 1.2, duration: 0.8)) {
                    tapCircle.removeFromParent()
                    
                    self.player?.destinationPosition = CGPoint(x: (self.player?.node?.position.x)! - 250, y: (self.player?.node?.position.y)!)
                    self.setTarget(at: CGPoint(x: (self.player?.node?.position.x)! - 250, y: (self.player?.node?.position.y)!))
                    
                    Timer.scheduledTimer(withTimeInterval: 2.4, repeats: false) { _ in
                        self.tutorialMsg += 1
                        self.nextTutorialMsg()
                    }
                }
            }
        }
        
        else if (tutorialMsg == 11) {

            self.tutorialWindow?.alpha = 1
          
            messageLabel?.text = "Чтобы передвигаться быстрее, нажмите на кнопку бега в правом нижнем углу. Это поможет быстрее убраться с места преступления, если шкала тревожности слишком заполнилась."
        
            self.tutorialMsg += 1
            
            nextBtnLabel?.text = "Далее"
        }
        else if (tutorialMsg == 12) {
            self.tutorialWindow?.alpha = 0
            self.tutorialMsg += 1
            
            self.runButton?.run(SKAction.scale(to: 1.4, duration: 1.0), completion: {
                self.runButton?.run(SKAction.scale(to: 1.0, duration: 0.4))
                self.nextTutorialMsg()
            })
            
        }
      
        else if (tutorialMsg == 13) {
            messageLabel?.text = "Для того чтобы осмотреться, двигайте камеру. Для этого нажмите пальцем на экран и удерживая его нажатым, двигайте палец в любом направлении."
            self.tutorialMsg += 1
            self.tutorialWindow?.alpha = 1
            
            nextBtnLabel?.text = "Показать"
        }
        else if (tutorialMsg == 14) {
            let tapCircle = SKShapeNode(circleOfRadius: 20)
            tapCircle.fillColor = .gray
            tapCircle.position = CGPoint(x: 0, y: 0)
            tapCircle.zPosition = 11
            self.cameraNode?.addChild(tapCircle)
            
            tapCircle.run(SKAction.scale(to: 1.2, duration: 0.4)) {
                
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
                    self.cameraNode?.run(SKAction.move(by: CGVector(dx: -240, dy: -100), duration: 1.0))
                    tapCircle.run(SKAction.move(by: CGVector(dx: 240, dy: 100), duration: 1.0)) {
                        
                        tapCircle.run(SKAction.scale(to: 1.0, duration: 0.4)) {
                            tapCircle.removeFromParent()
                            self.tutorialMsg += 1
                            self.nextTutorialMsg()
                        }
                        
                    }
                }
            }
        }
        else if tutorialMsg == 15 {
            messageLabel?.text = "Чтобы осматривать б\(UNICODE.oAccent)льшие участки карты или рассмотреть детали поближе, можно приблизить или отдалить камеру. Просто используйте жест 'Пинч'."
            self.tutorialMsg += 1
            self.tutorialWindow?.alpha = 1
            
            nextBtnLabel?.text = "Показать"
        }
        else if (tutorialMsg == 16) {
            let tapCircle1 = SKShapeNode(circleOfRadius: 20)
            tapCircle1.fillColor = .gray
            tapCircle1.position = CGPoint(x: 40, y: 40)
            tapCircle1.zPosition = 11
            self.cameraNode?.addChild(tapCircle1)
            
            let tapCircle2 = SKShapeNode(circleOfRadius: 20)
            tapCircle2.fillColor = .gray
            tapCircle2.position = CGPoint(x: -60, y: -60)
            tapCircle2.zPosition = 11
            self.cameraNode?.addChild(tapCircle2)
            
            tapCircle1.run(SKAction.scale(to: 1.2, duration: 0.4))
            tapCircle2.run(SKAction.scale(to: 1.2, duration: 0.4))
            
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
                self.cameraNode?.run(SKAction.scale(to: 1.4, duration: 1.0))
                
                tapCircle1.run(SKAction.move(by: CGVector(dx: -30, dy: -30), duration: 1.0))
                tapCircle2.run(SKAction.move(by: CGVector(dx: 30, dy: 30), duration: 1.0)) {
                    tapCircle1.run(SKAction.scale(to: 1.0, duration: 0.4))
                    tapCircle2.run(SKAction.scale(to: 1.0, duration: 0.4))
                    tapCircle1.alpha = 0
                    tapCircle2.alpha = 0
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 2.8, repeats: false) { _ in
                tapCircle1.alpha = 1
                tapCircle2.alpha = 1
                tapCircle1.run(SKAction.scale(to: 1.2, duration: 0.4))
                tapCircle2.run(SKAction.scale(to: 1.2, duration: 0.4))
                
                self.cameraNode?.run(SKAction.scale(to: self.minScale, duration: 1.0))
                
                tapCircle1.run(SKAction.move(by: CGVector(dx: 40, dy: 40), duration: 1.0))
                tapCircle2.run(SKAction.move(by: CGVector(dx: -40, dy: -40), duration: 1.0)) {
                    tapCircle1.run(SKAction.scale(to: 1.0, duration: 0.4))
                    tapCircle2.run(SKAction.scale(to: 1.0, duration: 0.4)) {
                        tapCircle1.removeFromParent()
                        tapCircle2.removeFromParent()
                        self.tutorialMsg += 1
                        self.nextTutorialMsg()
                    }
                }
            }
        }
        else if (tutorialMsg == 17) {
            messageLabel?.text = "Пользуйтесь мини-картой, на ней желтым кругом обозначена позиция игрока, зеленым - машины на карте. По мере игры будут появляться всё новые обозначения."
            self.tutorialMsg += 1
            self.tutorialWindow?.alpha = 1
            
            nextBtnLabel?.text = "Далее"
        }
        else if (tutorialMsg == 18) {
            self.tutorialMsg += 1
            self.tutorialWindow?.alpha = 0
            let miniMapStroke = self.cameraNode?.childNode(withName: "mini-map-stroke")
            
            self.miniMapCropNode?.run(SKAction.scale(to: 1.3, duration: 1.0), completion: {
                self.miniMapCropNode?.run(SKAction.scale(to: 1.0, duration: 0.4))
                
            })
            
            miniMapStroke?.run(SKAction.scale(to: 1.3, duration: 1.0), completion: {
                miniMapStroke?.run(SKAction.scale(to: 1.0, duration: 0.4), completion: {
                    self.nextTutorialMsg()
                })
            })
            
        }
        else if (tutorialMsg == 19) {
            messageLabel?.text = "Посмотреть задание для миссии можно, нажав на знак вопроса рядом с мини картой."
            self.tutorialMsg += 1
            self.tutorialWindow?.alpha = 1
            nextBtnLabel?.text = "Далее"
        }
        else if (tutorialMsg == 20) {
            self.tutorialMsg += 1
            self.tutorialWindow?.alpha = 0
            self.taskButton?.run(SKAction.scale(to: 1.5, duration: 1.0), completion: {
                self.taskButton?.run(SKAction.scale(to: 1.0, duration: 0.5), completion: {
                    self.nextTutorialMsg()
                })
            })
        }
        else if (tutorialMsg == 21) {
            messageLabel?.text = "Меню паузы можно вызвать, нажав на кнопку паузы в правом верхнем углу."
            self.tutorialWindow?.alpha = 1
            self.tutorialMsg += 1
            
            nextBtnLabel?.text = "Хорошо"
            
           
        }
        else if (tutorialMsg == 22) {
            self.menuButton?.run(SKAction.scale(to: 1.4, duration: 1.0), completion: {
                self.menuButton?.run(SKAction.scale(to: 1.0, duration: 0.4), completion: {
                    self.tutorialMsg += 1
                    self.nextTutorialMsg()
                })
            })
        }
        else if (tutorialMsg == 23) {
            messageLabel?.text = "Теперь вы готовы угнать свою первую машину, вперед, Босс ждет!"
            self.tutorialWindow?.alpha = 1
            self.tutorialMsg += 1
            nextBtnLabel?.text = "Закрыть"
            
        }
        else if tutorialMsg == 24 {
            self.tutorialWindow?.alpha = 0
            let act = SKAction.move(to: (player?.node?.position)!, duration: 2.0)
            self.cameraNode?.run(act, completion: {
                self.showBannerLabel(text: "Игра начинается")
                self.tutorialEnded = true
                self.canMoveCamera = true
                self.tutorialMsg += 1
                
                self.pushMessageToChat(text: "Добро пожаловать! Парковка №17 в спальном районе Чиперово города Сероветска.")
                
                Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 26...48)), repeats: false) { _ in
                    self.pushMessageToChat(text: "Босс хочет, чтобы вы потренировались на этой парковке и угнали для него машину, марка не важна.")
                }
            })
        }
    }
}

