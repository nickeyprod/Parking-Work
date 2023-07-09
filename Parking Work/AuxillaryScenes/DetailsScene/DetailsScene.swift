//
//  DetailsScene.swift
//  Parking Work
//
//  Created by Николай Ногин on 06.07.2023.
//

import SpriteKit

class DetailsScene: ParkingWorkGame {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // initial variables set
        setupInitialGameValues()
        
        // setup camera for adding inventory screen to camera node
        setupCamera()
        
        // create inventory (add it to camera node)
        createPlayerInventoryScreen()
    }
    
    override func update(_ currentTime: TimeInterval) {}
    
    
    override func setupInitialGameValues() {
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
        
        let backgroundSprite = self.childNode(withName: "backgroundNode")
        let detailsSprite = backgroundSprite?.childNode(withName: "DetailsSprite")
        
        let reputationSprite = detailsSprite?.childNode(withName: "ReputationSprite")
        let reputationLabel = reputationSprite?.childNode(withName: "ReputationLabel") as? SKLabelNode
        reputationLabel?.text = "Репутация: \(player?.reputation ?? 0)"
        
        let lockSprite = detailsSprite?.childNode(withName: "LockSprite")
        let unlockSkillLabel = lockSprite?.childNode(withName: "UnlockSkillLabel") as? SKLabelNode
        unlockSkillLabel?.text = "Скилл вскрытия: \(player?.unlockSkill ?? 0)"
        
        let walletSprite = detailsSprite?.childNode(withName: "WalletSprite")
        let walletLabel = walletSprite?.childNode(withName: "MoneyLabel") as? SKLabelNode
        walletLabel?.text = "Деньги: \(player?.money ?? 0.0)"
        
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
            
            let nodeName = touchedNode.name
            
            let firstCutString = nodeName?.split(separator: "-")[0]
            
            if firstCutString == "ui" {
                
                let secondCutString = nodeName?.split(separator: "-")[1]
                
                if secondCutString == "exitBtn" {
                    animateButtonClick(button: touchedNode as! SKSpriteNode) {
                        self.run(MenuSounds.button_click.action)
                        self.exitDetailsScreen()
                    }
                }
                else if secondCutString == "inventoryBtn" {
                    animateButtonClick(button: touchedNode as! SKSpriteNode) {
                        self.run(InventorySounds.bag_open.action)
                        self.openInventory()
                    }
                }
                else if secondCutString == "closeInventoryLabel" {
                    self.run(InventorySounds.bag_open.action)
                    self.closeInventory()
                }
            }
        
           
        }
        
    }
    
    func exitDetailsScreen() {
        let missionScene = SKScene(fileNamed: "MissionListScene") as? MissionList
        let transition = SKTransition.fade(with: .black, duration: 1.0)
        let displaySize: CGRect = UIScreen.main.bounds
        
        missionScene?.player = player
        missionScene?.gameLoaded = gameLoaded
        
        // Set the scale mode to scale to fit the window
        missionScene?.scaleMode = .aspectFill
        missionScene?.size = displaySize.size
        self.view?.presentScene(missionScene!, transition: transition)
    }
}
