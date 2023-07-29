//
//  ChatFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

// Chat Cotroling Game Functions
extension ParkingWorkGame {
    
    // Creates Chat Window at the left bottom of the screen
    func setupChatWindow() {
        
        // get messages chat window
        self.windowChat = SKCropNode()
        self.windowChat?.zPosition = 12
  
        let chatPos = CGPoint(x: -displayWidth! / 2 + 110, y: -displayHeight! / 2 + 95)
        self.windowChat?.position = chatPos
        
        let mask = SKShapeNode(rectOf: CGSize(width: CHAT_WIDTH, height: CHAT_HEIGHT), cornerRadius: 2)
        mask.fillColor = UIColor.white
        mask.alpha = 0.8
       
        let strokeShape = SKShapeNode(rectOf: CGSize(width: CHAT_WIDTH, height: CHAT_HEIGHT), cornerRadius: 2)
        strokeShape.position = self.windowChat!.position
        strokeShape.lineWidth = 2
        strokeShape.alpha = 0.7
        
        strokeShape.strokeColor = UIColor.black
        self.cameraNode?.addChild(strokeShape)
        
        self.windowChat?.maskNode = mask
        self.cameraNode?.addChild(self.windowChat!)
        
        // black background with alpha for chat
        let chatBackground = SKSpriteNode(imageNamed: "circle")
        chatBackground.name = "chat-background"
        chatBackground.alpha = 0.4
        chatBackground.zPosition = -1
        self.windowChat?.addChild(chatBackground)
        
        // create node in which we will be adding messages, for scrolling it
        // set color to green for debug
        let scrollingChatNode = SKSpriteNode(color: .clear, size: CGSize(width: CHAT_WIDTH, height: CHAT_HEIGHT))
        scrollingChatNode.anchorPoint = CGPoint(x: 0, y: 0)
 
        let x = self.windowChat?.maskNode!.frame.minX
        let y = self.windowChat?.maskNode!.frame.minY
        scrollingChatNode.position = CGPoint(x: x!, y: y!)
        self.scrollingChatNode = scrollingChatNode
        self.windowChat?.addChild(scrollingChatNode)
        
        // create slider
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 50.0))
        path.addLine(to: CGPoint(x: 40.0, y: -36.6))
        path.addLine(to: CGPoint(x: -40.0, y: -36.6))
        path.addLine(to: CGPoint(x: 0.0, y: 40.0))
        let triangleUp = SKShapeNode(path: path.cgPath)
        triangleUp.fillColor = .brown
        triangleUp.setScale(0.14)
        triangleUp.position = CGPoint(x: (CHAT_WIDTH / 2) - 8, y: (CHAT_HEIGHT / 2) - 8 )
        triangleUp.name = "ui-scroll-up-chat-btn"
        self.windowChat?.addChild(triangleUp)
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 0.0, y: -50.0))
        path2.addLine(to: CGPoint(x: -40.0, y: 36.6))
        path2.addLine(to: CGPoint(x: 40.0, y: 36.6))
        path2.addLine(to: CGPoint(x: 0.0, y: -40.0))
        
        let triangleDown = SKShapeNode(path: path2.cgPath)
        triangleDown.fillColor = .brown
        triangleDown.setScale(0.14)
        triangleDown.position = CGPoint(x: (CHAT_WIDTH / 2) - 8, y: -(CHAT_HEIGHT / 2) + 8 )
        triangleDown.name = "ui-scroll-down-chat-btn"
        self.windowChat?.addChild(triangleDown)
        
        self.updateChatSliderTopAndBottomEnds {
            let rangeInWhichSliderMoves = (self.chatSliderTopPos?.y)! - (self.chatSliderBottomPos?.y)!
            let slider = SKSpriteNode(color: .brown, size: CGSize(width: 8, height: rangeInWhichSliderMoves))
            slider.anchorPoint = CGPoint(x: 1, y: 1)
            slider.position = self.chatSliderBottomPos!
            
            slider.name = "ui-scroll-chat-slider"
            self.chatSlider = slider
            self.windowChat?.addChild(slider)
        }
    }
    
    // Resizes chat's slider accrording to number of messages in it
    func resizeSliderToActualHeight(completion: () -> Void) {
        self.chatSlider?.run(SKAction.resize(toHeight: self.chatSliderHeight!, duration: 0.15))
        // update Initial diff for right scrollig
        let sliderDiff = (self.chatSliderTopPos?.y)! - (self.chatSliderBottomPos?.y)!
        self.initialSliderDiff = sliderDiff
        return completion()
    }
    
    // Updates max Top and max Bottom ends between which slider moves
    func updateChatSliderTopAndBottomEnds(completion: () -> Void) {
        let numOfMessages = self.messagesInChat.count == 0 ? 1 : self.messagesInChat.count
        let rangeInWhichSliderMoves = (CHAT_HEIGHT - 32)
        
        let sliderHeight = rangeInWhichSliderMoves / numOfMessages
        
        self.chatSliderHeight = CGFloat(sliderHeight)

        let topSliderPos = CGPoint(x: (CHAT_WIDTH / 2) - 4, y: (CHAT_HEIGHT / 2) - 16)
        
        let bottomSliderPos = CGPoint(x: (CHAT_WIDTH / 2) - 4, y: -(CHAT_HEIGHT / 2) + sliderHeight + 16)
        
        self.chatSliderTopPos = topSliderPos
        self.chatSliderBottomPos = bottomSliderPos
        completion()
        
    }
    
    // Push new message to chat window
    func pushMessageToChat(text: String) {

        self.chatToBottom()
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let stringMinutes = String(minutes).count == 1 ? "0\(minutes)" : "\(minutes)"
        let textWithTime = "[\(hour):\(stringMinutes)] \(text)"
        
        let message = SKLabelNode(text: textWithTime)
        message.fontColor = UIColor.white
        message.fontSize = 16
        message.fontName = "\(FONTS.Baskerville)"

        message.position = CGPoint(x: 5, y: 10)
        message.preferredMaxLayoutWidth = 180
        message.numberOfLines = 0
        message.lineBreakMode = .byWordWrapping
        message.horizontalAlignmentMode = .left
        message.verticalAlignmentMode = .bottom
        
        movePrevMessagesUpper(newMsgHeight: message.frame.height)
        
        // append new message
        self.messagesInChat.append(message)
        self.scrollingChatNode?.addChild(message)
        
        let fullHeight = self.getFullHeight()

        // if all messages height total more that chat window height
        if fullHeight > Float(CHAT_HEIGHT) {
            
            // then need to change height of scroll node accordingly
            let newHeight = CGFloat(fullHeight + 15)

            self.scrollingChatNode?.run(SKAction.resize(toHeight: newHeight, duration: 0), completion: {
                self.updateChatSliderTopAndBottomEnds {
                    self.resizeSliderToActualHeight {
                        self.sliderToBottom()
                        self.initialScrollingDiff = abs((self.scrollingChatNode?.frame.maxY)!) - (self.windowChat?.maskNode?.frame.maxY)!
                    }
                }
            })
        }
    }
    
    // Get total height of all messages that currently is in scrolling node
    func getFullHeight() -> Float {
        var fullHeight: Float = 0
        self.messagesInChat.forEach { msg in
            fullHeight = fullHeight + Float((msg?.frame.height)!)
        }
        return fullHeight
    }
    
    // Set new message to bottom and move previous higher on new mesage height
    func movePrevMessagesUpper(newMsgHeight: CGFloat) {
        self.messagesInChat.forEach { message in
            let currPos = message?.position
            let newPos = CGPoint(x: currPos!.x, y: currPos!.y + newMsgHeight)
            message?.position = newPos
        }
    }
    
    // Move scrolling node upper
    func scrollChatUp() {
        
        let currPos = (self.scrollingChatNode?.frame.maxY)!
        let maxPos = (self.windowChat?.maskNode?.frame.maxY)!

        let timesToReachTop = Float(self.initialScrollingDiff! / 10).rounded(.up)
        let step = self.initialSliderDiff! / CGFloat(timesToReachTop)

        self.currScrollingStep = step

        if currPos > maxPos {
            // move messages
            self.scrollingChatNode?.position = CGPoint(x: (self.scrollingChatNode?.position.x)!, y: (self.scrollingChatNode?.position.y)! - 10)
                
            // move slider
            self.chatSlider?.position = CGPoint(x: (self.chatSlider?.position.x)!, y: (self.chatSlider?.position.y)! + self.currScrollingStep!)
        }

    }
    
    // Move scrolling node lower
    func scrollChatDown() {
        
        let currPos = (self.scrollingChatNode?.frame.minY)!
        let maxPos = (self.windowChat?.maskNode?.frame.minY)!
        
        if currPos < maxPos {
            // move messages
            self.scrollingChatNode?.position = CGPoint(x: (self.scrollingChatNode?.position.x)!, y: (self.scrollingChatNode?.position.y)! + 10)
                
            // move slider
            self.chatSlider?.position = CGPoint(x: (self.chatSlider?.position.x)!, y: (self.chatSlider?.position.y)! - self.currScrollingStep!)
        }
    }
    
    // move slider to bottom, or to the end of chat
    func sliderToBottom() {
        self.chatSlider?.position = self.chatSliderBottomPos!
    }
    
    func chatToBottom() {
        self.sliderToBottom()
        let x = self.windowChat?.maskNode!.frame.minX
        let y = self.windowChat?.maskNode!.frame.minY
        self.scrollingChatNode!.position = CGPoint(x: x!, y: y!)
    }
}
