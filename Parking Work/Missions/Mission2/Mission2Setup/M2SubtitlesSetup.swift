//
//  M2SubtitlesSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 26.07.2023.
//

import Foundation
import SpriteKit

extension Mission2 {
    func runVladikDoorRingSubtitles() {
        
        // remove action sprite 
        let doorActionSprite = self.childNode(withName: "door-action") as? SKSpriteNode
        doorActionSprite?.removeAllActions()
        doorActionSprite?.removeFromParent()
        
        canRotate = false
        
        player?.destinationPosition = player?.node?.position
        
        let action = SKAction.rotate(toAngle: 3.1449, duration: 0.1, shortestUnitArc: true)
        player!.node!.run(action)
        
        isUILocked = true
        
        let subtitlesSquare = SKSpriteNode(color: .black, size: CGSize(width: displayWidth!, height: 60))
        subtitlesSquare.alpha = 0.85
        subtitlesSquare.zPosition = 16
        subtitlesSquare.anchorPoint = CGPoint(x: 0.5, y: 0)
        subtitlesSquare.position = CGPoint(x: 0, y: -(displayHeight! / 2))
        
        let label = SKLabelNode(text: "Владик: - Да, кто здесь?")
        label.fontName = FONTS.AmericanTypewriter
        label.fontSize = 16
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: subtitlesSquare.frame.height / 2)
        label.preferredMaxLayoutWidth = subtitlesSquare.frame.width - 100
        label.numberOfLines = 0
        subtitlesSquare.addChild(label)
        subtitlesLabel = label
        

        
        Timer.scheduledTimer(withTimeInterval: 6, repeats: false) { _ in
            self.cameraNode?.addChild(subtitlesSquare)
        }
        
        Timer.scheduledTimer(withTimeInterval: 12.5, repeats: false) { _ in
            self.subtitlesLabel?.text = " - Владик, меня просили передать тебе информацию от Алека Чангиса, ты же его знаешь?"
        }
        
        Timer.scheduledTimer(withTimeInterval: 21.0, repeats: false) { _ in
            self.subtitlesLabel?.text = "Владик:  - Аа Чангис, Чанга.. да.. я помню этого... Олуха!, да.. шел бы он к черту? А ты кто такой??"
        }
        
        Timer.scheduledTimer(withTimeInterval: 31.0, repeats: false) { _ in
            self.subtitlesLabel?.text = " - Меня зовут Федор. Я хочу просто поговорить с тобой по-хорошему, как говорится, передать информацию."
        }
        
        Timer.scheduledTimer(withTimeInterval: 38.0, repeats: false) { _ in
            self.subtitlesLabel?.text = "Владик:  - Федя, вали отсюда пока жопу не намылили! Мне некогда, у меня тут моя... дама она... вообщем она не должна ждать. Пошел ты! Федя!"
        }
        
        
        Timer.scheduledTimer(withTimeInterval: 49, repeats: false) { _ in
            self.isUILocked = false
            self.canRotate = true
            subtitlesSquare.removeFromParent()
        }
        
        Timer.scheduledTimer(withTimeInterval: 52, repeats: false) { _ in
            self.runVladikCarCrashInstructions()
        }
    
    }
    
    func runVladikCarCrashInstructions() {
        
        
        // change (update) task message in task screen here!!
        
        let messageSquare = SKSpriteNode(color: .black, size: CGSize(width: displayWidth! / 2, height: displayHeight! / 2))
        messageSquare.alpha = 0.80
        messageSquare.zPosition = 16
        messageSquare.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        messageSquare.position = CGPoint(x: 0, y: 0)
        
        let label = SKLabelNode(text: "Владик оказался несговорчив! Ну ничего, у Владика есть тачка, она стоит во дворе за углом. Можно сделать с ней что-то? Главное следи за шкалой шума!")
        
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: (messageSquare.frame.height / 2) - 20)
        label.numberOfLines = 0
        label.fontName = FONTS.Baskerville
        label.fontSize = 18
        label.preferredMaxLayoutWidth = messageSquare.frame.width - 40
        messageSquare.addChild(label)
        
        vladikCrashInstructionsMessage = messageSquare
        vladikCrashInstructionsMessageLabel = label
        
        self.cameraNode?.addChild(messageSquare)
        
        let confirmButton = SKSpriteNode(color: .blue, size: CGSize(width: 76, height: 32))
        confirmButton.name = "ui-confirm-button"
        let confirmLabel = SKLabelNode(text: "Понятно")
        confirmLabel.name = "ui-confirm-label"
        confirmLabel.horizontalAlignmentMode = .center
        confirmLabel.verticalAlignmentMode = .center
        confirmLabel.fontName = FONTS.Cochin
        confirmLabel.fontSize = 15
        confirmButton.position = CGPoint(x: 0, y: -messageSquare.frame.height / 2 + confirmButton.frame.height)
        confirmButton.addChild(confirmLabel)
        messageSquare.addChild(confirmButton)
        
        // turn on cigarette emitter and set it as takable item
        cigaretteItemEmitter?.particleBirthRate = 15
        cigaretteFire?.physicsBody = SKPhysicsBody(rectangleOf: cigaretteFire!.size)
        cigaretteFire?.physicsBody?.affectedByGravity = false
        cigaretteFire?.physicsBody?.categoryBitMask = gameItemCategory
        cigaretteFire?.physicsBody?.collisionBitMask = 0
        cigaretteFire?.physicsBody?.contactTestBitMask = playerCategory
        
        let cigarette = GameItem(
            id: ITEMS_TYPES.AUXILLARIES.smolderingCigarette.id,
            name: ITEMS_TYPES.AUXILLARIES.smolderingCigarette.name,
            node: cigaretteFire,
            type: ITEMS_TYPES.AUXILLARIES.TYPE,
            assetName: ITEMS_TYPES.AUXILLARIES.smolderingCigarette.assetName,
            description: ITEMS_TYPES.AUXILLARIES.smolderingCigarette.description,
            properties: ITEMS_TYPES.AUXILLARIES.smolderingCigarette.properties
        )
        
        itemsOnMission.append(cigarette)
        
        cigaretteFire?.userData = NSMutableDictionary()
        cigaretteFire?.userData?.setValue(cigarette.self, forKeyPath: "self")
    }
}
