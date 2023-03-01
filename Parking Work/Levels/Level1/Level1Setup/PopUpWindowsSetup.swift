//
//  popUpsSetuo.swift
//  Parking Work
//
//  Created by Николай Ногин on 14.02.2023.
//

import SpriteKit

// Level 1 Pop-up Windows Setup
extension Level1 {
    
    // MARK: - Pop-up Windows Setup
    /// Setup of all pop-up window messages
    func setupPopUpWindowMessages() {
        // open car window message
        self.setupOpenCarWindowMessage()
        // open car window success message
        self.setupOpenCarSuccessWindowMessage()
    }
    
    
    // Open car success pop-up window
    func setupOpenCarSuccessWindowMessage() {
        // get open car succeess window itself
        openCarSuccessWindow = self.childNode(withName: "carInfoWindow")
        openCarSuccessWindow?.alpha = 0
        openCarSuccessWindow?.zPosition = 12 // player=10, suggestpopUp=11 + 1
        
        // open car success window labels
        openCarSuccessWindowSuccessLabel = openCarSuccessWindow?.childNode(withName: "successLabel") as? SKLabelNode
        openCarSuccessWindowGarageLabel = openCarSuccessWindow?.childNode(withName: "garageLabel") as? SKLabelNode
        openCarSuccessWindowGoodBtn = openCarSuccessWindow?.childNode(withName: "goodButton")
        openCarSuccessWindowGoodBtnLabel = openCarSuccessWindow?.childNode(withName: "goodLabel") as? SKLabelNode
    }
    
    // Open car suggest - pop-up window
    func setupOpenCarWindowMessage() {
        // get open car window itself
        openCarWindow = self.childNode(withName: "openCarMessageWindow")
        
        // open car window labels
        //  - car name label
        openCarWindowNameLabel = openCarWindow?.childNode(withName: "carNameLabel") as? SKLabelNode

        // - lock type label
        openCarWindowLockTypeLabel = openCarWindow?.childNode(withName: "lockTypeLabel") as? SKLabelNode
        
        // complexity level label
        let openCarWindowComplexityLabel = openCarWindow?.childNode(withName: "complexityLabel") as? SKLabelNode
        
        // complexity level number
        openCarWindowComplexityNum = openCarWindowComplexityLabel?.childNode(withName: "complexityNumLevel") as? SKLabelNode
    
    }
}
