//
//  popUpsSetuo.swift
//  Parking Work
//
//  Created by Николай Ногин on 14.02.2023.
//

import SpriteKit

// Pop-up Windows Setup
extension ParkingWorkGame {
    
    func setupOpenCarWindowMessage() {
        // get open car window itself
        openCarWindow = self.childNode(withName: "openCarMessageWindow")
        openCarWindow?.alpha = 0
        openCarWindow?.zPosition = 11 // player=10 + 1
        
        // open car window labels
        //  - car name label
        openCarWindowNameLabel = openCarWindow?.childNode(withName: "carNameLabel") as? SKLabelNode
        openCarWindowNameLabel?.fontSize = 58
        openCarWindowNameLabel?.position = CGPoint(x: (openCarWindow?.frame.width)! / 2, y: (openCarWindow?.frame.height)! - 38)

        // - message label set to 'Попробовать вскрыть?' initially
        let openCarWindowMsgLabel = openCarWindow?.childNode(withName: "carMessage") as? SKLabelNode
        openCarWindowMsgLabel?.text = "Попробовать вскрыть?"
        openCarWindowMsgLabel?.position = CGPoint(x: (openCarWindow?.frame.width)! / 2, y: (openCarWindow?.frame.height)! - 80)
        
        // - lock type label
        openCarWindowLockTypeLabel = openCarWindow?.childNode(withName: "lockTypeLabel") as? SKLabelNode
        openCarWindowLockTypeLabel?.position = CGPoint(x: (openCarWindow?.frame.width)! / 2, y: (openCarWindow?.frame.height)! - 90)
        
        // complexity level label
        let openCarWindowComplexityLabel = openCarWindow?.childNode(withName: "complexityLabel") as? SKLabelNode
        openCarWindowComplexityLabel?.fontSize = 18
        openCarWindowComplexityLabel?.position = CGPoint(x: (openCarWindow?.frame.width)! / 2 - 35, y: (openCarWindow?.frame.height)! - 112)
        
        // complexity level number
        openCarWindowComplexityNum = openCarWindowComplexityLabel?.childNode(withName: "complexityNumLevel") as? SKLabelNode
        openCarWindowComplexityNum?.fontSize = 18
        openCarWindowComplexityNum?.position = CGPoint(x: (openCarWindowComplexityLabel?.frame.width)! - 8, y: 0)
        
        // yes/no open car buttons
        let yesBtn = openCarWindow?.childNode(withName: "yesOpenLockBtn")
        let noBtn = openCarWindow?.childNode(withName: "noOpenLockBtn")
        
        // yes/no button labels
        let yesLabel = yesBtn?.childNode(withName: "yesBtnLabel")
        let noLabel = noBtn?.childNode(withName: "noBtnLabel")
        
        // position text at the center of button
        yesLabel?.position = CGPoint(x: 0, y: 0)
        noLabel?.position = CGPoint(x: 0, y: 0)
    }

}
