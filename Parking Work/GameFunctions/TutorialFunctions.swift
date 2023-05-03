//
//  TutorialFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

// Tutorial Game Functions
extension ParkingWorkGame {
    
    // Show tutorial about car locks
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
    
    // Set showing tutorial at the start of the game to true/false
    func tutorial(set to: Bool) {
        
        // set this vars to true when game restarted, to not show tutorials and does not block any UI
        if to == false {
            self.tutorialEnded = true
            self.firstCarOpened = true
            self.canMoveCamera = true
            self.restart = true
        } else {
            self.tutorialEnded = false
            self.firstCarOpened = false
            self.canMoveCamera = false
            self.restart = false
        }
    }
}
