//
//  SplashScreen.swift
//  Parking Work
//
//  Created by Николай Ногин on 24.05.2023.
//

import SpriteKit
import Foundation
import GameplayKit
import AVFoundation

class SplashScreen: ParkingWorkGame {
    
    var systemWhiteBack: SKSpriteNode?
    var parkingWorkImage: SKSpriteNode?

    var videoNode: SKVideoNode?
    var avPlayer: AVPlayer? = {
        guard let urlString = Bundle.main.path(forResource: "pinplay_logo", ofType: "mp4") else {
               return nil
           }
           
        let url = URL(fileURLWithPath: urlString)
        let item = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: item)

           
        return player
    }()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // setup intial variables
        setupInitialGameValues()
        
        // system white background size of screen
        systemWhiteBack?.size = CGSize(width: displayWidth!, height: displayHeight!)
        systemWhiteBack?.position = CGPoint(x: 0, y: 0)
        
        // parking work image size of screen
        parkingWorkImage?.size = CGSize(width: displayWidth!, height: displayHeight!)
        parkingWorkImage?.position = CGPoint(x: 0, y: 0)
        
        // initialize Video Node with Video for Splash Screen Logo Animation
        videoNode = SKVideoNode(avPlayer: avPlayer!)
        videoNode?.size = CGSize(width: displayWidth!, height: displayHeight!)
        addChild(videoNode!)
        
        // play it
        videoNode?.play()
        
        // add Presents label
        let presentsLabel = SKLabelNode(text: "Представляет")
        presentsLabel.fontSize = 26
        presentsLabel.fontName = "Baskerville-bold"
        presentsLabel.position = CGPoint(x: 0, y: -120)
        presentsLabel.fontColor = .black
        presentsLabel.alpha = 0
        addChild(presentsLabel)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            presentsLabel.run(.fadeIn(withDuration: 1.0)) {
                presentsLabel.run(.fadeOut(withDuration: 1.8))
            }
        }
        

        // notify when playing of logo video has ended
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer?.currentItem)
    }
    
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        // show parking work on asphalt image
        self.videoNode?.removeFromParent()
        parkingWorkImage?.run(SKAction.fadeIn(withDuration: 1.0), completion: {
            print("11")
            let cigaretteImg = UIImage(named: "sigareta")
            let cigarette = SKSpriteNode(texture: SKTexture(image: cigaretteImg!))
            cigarette.position = CGPoint(x: 90, y: -60)
            cigarette.zRotation = 0
            cigarette.anchorPoint = CGPoint(x: 1.0, y: 0.5)
            cigarette.size = CGSize(width: 50, height: 50)
            cigarette.setScale(6.0)
            
            Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { _ in
                cigarette.run(.scale(to: 1.0, duration: 0.4)) {
                    self.run(Sound.cigarette_falling.action)
                    
                    let smokeEmitter = SKEmitterNode(fileNamed: "CigaretteSmoke.sks")
                    smokeEmitter?.position = CGPoint(x: 90, y: -60)
                    self.addChild(smokeEmitter!)
                    
                    Timer.scheduledTimer(withTimeInterval: 2.8, repeats: false) { _ in
                        smokeEmitter?.run(.fadeOut(withDuration: 0.7))
                        cigarette.run(.fadeOut(withDuration: 0.7))
                        self.parkingWorkImage?.run(.fadeOut(withDuration: 1.0), completion: {
                            self.runGame()
                        })
                    }
                }
                cigarette.run(.rotate(toAngle: 1.82, duration: 1.0))
                
                self.addChild(cigarette)
            }
            
        })
    }
    
    func runGame() {
        let gameScene = GKScene(fileNamed: "IntroScene")?.rootNode as! ParkingWorkGame
        
        let transition = SKTransition.fade(with: .black, duration: 1.0)
        let displaySize: CGRect = UIScreen.main.bounds
        // Set the scale mode to scale to fit the window
        gameScene.scaleMode = .aspectFill
        gameScene.size = displaySize.size
        
        self.view?.presentScene(gameScene, transition: transition)
    }
    
    override func setupInitialGameValues() {
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
        
        systemWhiteBack = childNode(withName: "sys-white-background") as? SKSpriteNode
        parkingWorkImage = self.childNode(withName: "pw-logo") as? SKSpriteNode
    }
    
    override func update(_ currentTime: TimeInterval) {
        
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
            print("touch")
        }
    }
   
                           
}
