//
//  PopUpWindowsSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 14.02.2023.
//

import SpriteKit

// Game Pop-up Windows Setup
extension ParkingWorkGame {
    
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
    
    // Initialize empty Fast Access Panel and hide it initially
    func setupFastAccessPanel() {
        // Initialize Panel
        self.fastAccessPanel = FastAccessPanel()
        
        // Create and hide Shape Node of the panel
        self.fastAccessPanel?.scene = self
        self.fastAccessPanel?.createPanel()
    }
}
