//
//  GameViewController.swift
//  Parking Work
//
//  Created by Николай Ногин on 19.01.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "Level1Scene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! ParkingWorkGame? {
//                sceneNode.tutorialEnded = true
//                sceneNode.firstCarOpened = true
//                sceneNode.canMoveCamera = true
//                sceneNode.restart = true
//                
                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
                
                let displaySize: CGRect = UIScreen.main.bounds
//                let displayWidth = displaySize.width
//                let displayHeight = displaySize.height
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                sceneNode.size = displaySize.size
//                sceneNode.view?.widthAnchor = displayWidth
//                sceneNode.view?.heightAnchor = displayHeight
                
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = false
                    
                    view.showsFPS = false
                    view.showsNodeCount = false
                    view.showsPhysics = true
                }
            }
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
