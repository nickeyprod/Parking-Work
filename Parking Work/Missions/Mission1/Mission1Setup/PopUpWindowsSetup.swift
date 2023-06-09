//
//  popUpsSetuo.swift
//  Parking Work
//
//  Created by Николай Ногин on 14.02.2023.
//

import SpriteKit

// Mission 1 Pop-up Windows Setup
extension Mission1 {
    
    // MARK: - Pop-up Windows Setup
    /// Setup of all pop-up window messages
    func setupPopUpWindowMessages() {
        
        // open car window message
        self.setupTargetMessageWindow()
        // open car window success message
        self.setupOpenCarSuccessWindowMessage()

    }
    
    
    // Open car success pop-up window
    func setupOpenCarSuccessWindowMessage() {
        // get open car succeess window itself
        openCarSuccessWindow = self.cameraNode?.childNode(withName: "openCarSuccessWindow")
        // get car [name] will go to garage label
        openCarSuccessWindowGarageLabel = openCarSuccessWindow?.childNode(withName: "garageLabel") as? SKLabelNode
    }
    
    // Target message - pop-up window
    func setupTargetMessageWindow() {
        
        // target window labels
        //  - target name label
        targetWindowNameLabel = targetWindow?.childNode(withName: "carNameLabel") as? SKLabelNode

        // - lock type label
        targetWindowLockTypeLabel = targetWindow?.childNode(withName: "lockTypeLabel") as? SKLabelNode
        
        // complexity level label
        let openCarWindowComplexityLabel = targetWindow?.childNode(withName: "complexityLabel") as? SKLabelNode
        
        // complexity level number
        targetWindowComplexityNum = openCarWindowComplexityLabel?.childNode(withName: "complexityNumLevel") as? SKLabelNode
    
    }
}
