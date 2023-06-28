//
//  Shop.swift
//  Parking Work
//
//  Created by Николай Ногин on 02.06.2023.
//

import SpriteKit

class Shop: ParkingWorkGame {
    
    var mainHeader: SKLabelNode?
    var moneyLabel: SKLabelNode?
    var moneyIcon: SKSpriteNode?
    var buyButton: SKSpriteNode?
    var shopInventoryButton: SKSpriteNode?
    
    // background
    var background: SKSpriteNode?
    var leftSide: SKSpriteNode?
    var rightSide: SKSpriteNode?
    var woodenBack: SKSpriteNode?
    var shopItemDescWindow: SKSpriteNode?
    var shopItemPropertiesWindow: SKSpriteNode?
    
    var shopItemNameLabel: SKLabelNode?
    var shopItemPriceLabel: SKLabelNode?
    var shopItemDescriptionLabel: SKLabelNode?
    
    var initialCellPosY: CGFloat?
    
    var currSelectedItem: ShopItem?
    
    var shopItems: [ShopItem] = []

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // load player data
        loadPlayerProgress()
        
        // setup all needed variables
        setupInitialGameValues()
        
        // setup camera for adding inventory screen to camera node
        setupCamera()
        
        // create inventory (add it to camera node)
        createPlayerInventoryScreen()
        
        // fill shop with Items
        fillShopItems()
        
        // setup all nodes
        setupShop()
        
    }
    
    override func update(_ currentTime: TimeInterval) {}
    
    
    override func setupInitialGameValues() {
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
        
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
            
            if firstCutString == "shopItem" {
                if let selectedItem = touchedNode.userData?.value(forKeyPath: "self") as? ShopItem {
                    
                    // select Item
                    currSelectedItem = selectedItem
                    select(touchedNode: touchedNode, selectedItem: selectedItem)
                    run(MenuSounds.button_click.action)
                    
                }
            } else if nodeName == "ui-buy-button" || nodeName == "ui-buy-button-label"  {
                animateButtonClick(button: buyButton!, done: nil)
                run(MenuSounds.button_click.action)
                print("buy item!!!")
            } else if nodeName == "ui-inventory-button" {
                animateButtonClick(button: shopInventoryButton!, done: nil)
                run(InventorySounds.bag_open.action)
                openInventory()
            } else if nodeName == "ui-closeInventoryBtn" || nodeName == "ui-closeInventoryLabel" {
                run(InventorySounds.bag_open.action)
                closeInventory()
            } else if nodeName == "ui-exit-shop-btn" {
                run(MenuSounds.button_click.action)
                animateButtonClick(button: touchedNode as! SKSpriteNode, done: { [self] in
                    exitShopScreen()
                })
                
            }
        }
        
    }
    
    func select(touchedNode: SKNode, selectedItem: ShopItem) {
        
        buyButton?.removeAllActions()
        
        buyButton?.alpha = 0.95
        buyButton?.xScale = 1.0
        buyButton?.yScale = 1.0
        
        // fill description of selected item
        fillItemDescriptionWindow(for: selectedItem)
        
        // select (highlight) item
        highlightItem(itemNode: touchedNode.parent!, squareWidth: touchedNode.frame.width)
        
        // animate item
        animateShopItem(itemNode: touchedNode as! SKSpriteNode)
        
        // animate button again
        animateShopBuyButton(button: buyButton!)
    }
    
    func fillItemDescriptionWindow(for selectedItem: ShopItem) {
        // item name
        shopItemNameLabel?.text = selectedItem.name
        
        // item price
        if selectedItem.onlyForRealMoney {
            shopItemPriceLabel?.text = "Стоимость: \(selectedItem.price.rubPrice) \(UNICODE.rubleSymbol)"
        } else {
            shopItemPriceLabel?.text = "Стоимость: \(selectedItem.price.gamePrice)"
        }
        
        shopItemPriceLabel?.position = CGPoint(x: 0, y: (shopItemNameLabel?.position.y)! - (shopItemNameLabel?.frame.height)! - 10 )
        
        // item description
        shopItemDescriptionLabel?.text = selectedItem.description
        shopItemDescriptionLabel?.position = CGPoint(x: 0, y: (shopItemPriceLabel?.position.y)! - (shopItemPriceLabel?.frame.height)! - 10)
        
        fillItemProperties(properties: selectedItem.properties) { windowPropsHeight in
            shopItemPropertiesWindow?.size = CGSize(width: (shopItemDescWindow?.frame.width)! - 10, height: windowPropsHeight)
            
            // update properties window position
            shopItemPropertiesWindow?.position = CGPoint(x: 0, y: (shopItemDescriptionLabel?.position.y)! - (shopItemDescriptionLabel?.frame.height)! - 20 )
        }
        
    }
    
    func fillShopItems() {
        
        // USUAL PICKLOCK
        let usualPicklockNode = SKSpriteNode(imageNamed: ITEMS_TYPES.PICKLOCKS.usual_picklock.assetName)
        shopItems.append(
            ShopItem(
                name: ITEMS_TYPES.PICKLOCKS.usual_picklock.name,
                onlyForRealMoney: false,
                node: usualPicklockNode,
                type: ITEMS_TYPES.PICKLOCKS.TYPE,
                price: Price(rubPrice: 5, gamePrice: 15),
                assetName: ITEMS_TYPES.PICKLOCKS.usual_picklock.assetName,
                description: ITEMS_TYPES.PICKLOCKS.usual_picklock.description,
                properties: ITEMS_TYPES.PICKLOCKS.usual_picklock.properties
            )
        )
        
        // BETTER PICKLOCK
        let betterPicklockNode = SKSpriteNode(imageNamed: ITEMS_TYPES.PICKLOCKS.better_picklock.assetName)
        shopItems.append(
            ShopItem(
                name: ITEMS_TYPES.PICKLOCKS.better_picklock.name,
                onlyForRealMoney: false,
                node: betterPicklockNode,
                type: ITEMS_TYPES.PICKLOCKS.TYPE,
                price: Price(rubPrice: 15, gamePrice: 45),
                assetName: ITEMS_TYPES.PICKLOCKS.better_picklock.assetName,
                description: ITEMS_TYPES.PICKLOCKS.better_picklock.description,
                properties: ITEMS_TYPES.PICKLOCKS.better_picklock.properties
            )
        )
        
        // PROFESSIONAL PICKLOCK
        let professionalPicklockNode = SKSpriteNode(imageNamed: ITEMS_TYPES.PICKLOCKS.professional_picklock.assetName)
        shopItems.append(
            ShopItem(
                name: ITEMS_TYPES.PICKLOCKS.professional_picklock.name,
                onlyForRealMoney: true,
                node: professionalPicklockNode,
                type: ITEMS_TYPES.PICKLOCKS.TYPE,
                price: Price(rubPrice: 49, gamePrice: 0),
                assetName: ITEMS_TYPES.PICKLOCKS.professional_picklock.assetName,
                description: ITEMS_TYPES.PICKLOCKS.professional_picklock.description,
                properties: ITEMS_TYPES.PICKLOCKS.professional_picklock.properties
            )
        )
    }
    
    func setupShop() {
        
        // shop background
        background = SKSpriteNode(color: .black, size: CGSize(width: displayWidth!, height: displayHeight!))
        addChild(background!)
        
        leftSide = SKSpriteNode(color: .black, size: CGSize(width: displayWidth! / 3, height: displayHeight!))
        leftSide?.position = CGPoint(x: -(displayWidth! / 3) , y: 0)
        addChild(leftSide!)
        
        woodenBack = SKSpriteNode(imageNamed: "shop_wooden_back")
        woodenBack?.size = CGSize(width: (leftSide?.frame.width)! - 4, height: (leftSide?.frame.height)!)
        leftSide?.addChild(woodenBack!)
        
        shopItemDescWindow = SKSpriteNode(color: .black, size: CGSize(width: (leftSide?.frame.width)! - 20, height: (leftSide?.frame.height)! - 100))
        shopItemDescWindow?.alpha = 0.5
        
        shopItemDescWindow?.position = CGPoint(x: 0, y: -20)
        
        woodenBack?.addChild(shopItemDescWindow!)
        
        // shop item name
        shopItemNameLabel = SKLabelNode(text: "Имя вещи")
        shopItemNameLabel?.position = CGPoint(x: 0, y: (shopItemDescWindow?.frame.height)! / 2 - 10)
        shopItemNameLabel?.preferredMaxLayoutWidth = (shopItemDescWindow?.frame.width)! - 10
        shopItemNameLabel?.numberOfLines = 0
        shopItemNameLabel?.lineBreakMode = .byCharWrapping
        shopItemNameLabel?.verticalAlignmentMode = .top
        shopItemNameLabel?.horizontalAlignmentMode = .center
        shopItemNameLabel?.fontSize = 16
        shopItemNameLabel?.fontName = FONTS.AmericanTypewriter
        shopItemDescWindow?.addChild(shopItemNameLabel!)
        
        // shop item price
        shopItemPriceLabel = SKLabelNode(text: "Стоимость: 10")
        shopItemPriceLabel?.position = CGPoint(x: 0, y: (shopItemNameLabel?.position.y)! - (shopItemNameLabel?.frame.height)! - 10 )
        shopItemPriceLabel?.verticalAlignmentMode = .top
        shopItemPriceLabel?.horizontalAlignmentMode = .center
        shopItemPriceLabel?.fontSize = 15
        shopItemPriceLabel?.fontName = FONTS.AmericanTypewriter
        
        shopItemDescWindow?.addChild(shopItemPriceLabel!)
        
        // shop item short description
        shopItemDescriptionLabel = SKLabelNode(text: "Короткое описание вещички")
        shopItemDescriptionLabel?.position = CGPoint(x: 0, y: (shopItemPriceLabel?.position.y)! - (shopItemPriceLabel?.frame.height)! - 20 )
        shopItemDescriptionLabel?.lineBreakMode = .byWordWrapping
        shopItemDescriptionLabel?.verticalAlignmentMode = .top
        shopItemDescriptionLabel?.horizontalAlignmentMode = .center
        
        shopItemDescriptionLabel?.numberOfLines = 0
        shopItemDescriptionLabel?.preferredMaxLayoutWidth = (shopItemDescWindow?.frame.width)! - 20
        shopItemDescriptionLabel?.fontSize = 14
        shopItemDescriptionLabel?.fontName = FONTS.AmericanTypewriter
        shopItemDescWindow?.addChild(shopItemDescriptionLabel!)
        
        // item properties window
        shopItemPropertiesWindow = SKSpriteNode(color: .black, size: CGSize(width: (shopItemDescWindow?.frame.width)! - 10, height: 30))
        shopItemPropertiesWindow?.name = "properties-window"
        shopItemPropertiesWindow?.anchorPoint = CGPoint(x: 0.5, y: 1)
        shopItemPropertiesWindow?.position = CGPoint(x: 0, y: (shopItemDescriptionLabel?.position.y)! - (shopItemDescriptionLabel?.frame.height)! - 10)
        
        // fill properties window with item's propeties
        fillItemProperties(properties: []) { windowPropsHeight in
            
            // add after window has been filled
            shopItemPropertiesWindow?.size = CGSize(width: (shopItemDescWindow?.frame.width)! - 10, height: windowPropsHeight)

            shopItemDescWindow?.addChild(shopItemPropertiesWindow!)
        }
        
//        rightSide = SKSpriteNode(color: .darkText, size: CGSize(width: (displayWidth! / 3) * 2, height: displayHeight!))
        
        rightSide = SKSpriteNode(imageNamed: "shop_shelves")
        rightSide?.anchorPoint = CGPoint(x: 0, y: 1)
       
        rightSide?.position = CGPoint(x: -(displayWidth! / 3) + (displayWidth! / 3) / 2 , y: displayHeight! / 2 - 20)
        rightSide?.setScale(1.5)
        addChild(rightSide!)
        
        let boardPlate = SKSpriteNode(imageNamed: "board_plate")
        boardPlate.anchorPoint = CGPoint(x: 0.5, y: 1)
        boardPlate.position = CGPoint(x: 0, y: displayHeight! / 2 + 40)
        boardPlate.size = CGSize(width: displayWidth! / 2 + 80, height: displayHeight! / 3)
        boardPlate.alpha = 0.8
        addChild(boardPlate)
        
        // main header of shop
        mainHeader = SKLabelNode(text: "Городская Лавка")
        mainHeader?.verticalAlignmentMode = .top
        mainHeader?.position = CGPoint(x: 0, y: -(boardPlate.frame.height / 2) + 6)
        mainHeader?.fontName = FONTS.AmericanTypewriter
        mainHeader?.fontSize = 28
        mainHeader?.fontColor = .lightText
        boardPlate.addChild(mainHeader!)
         
        // ======= setup UI Buttons =======
        
        // money icon
        moneyIcon = SKSpriteNode(imageNamed: "money")
        moneyIcon?.size = CGSize(width: 28, height: 28)
        moneyIcon?.position = CGPoint(x: -(displayWidth! / 2) + 25, y: (displayHeight! / 2) - 25 )
        
        addChild(moneyIcon!)
        
        // money label
        moneyLabel = SKLabelNode(text: "20")
        moneyLabel?.position = CGPoint(x: -(displayWidth! / 2) + 60, y: (displayHeight! / 2) - 25 )
        moneyLabel?.verticalAlignmentMode = .center
        moneyLabel?.fontSize = 22
        moneyLabel?.fontName = FONTS.AmericanTypewriter
        addChild(moneyLabel!)
        
        // exit from shop button
//        let exitButton = SKSpriteNode(color: .red, size: CGSize(width: 35, height: 35))
        let exitSprite = SKSpriteNode(imageNamed: "exit-door")
        exitSprite.name = "ui-exit-shop-btn"
        exitSprite.size = CGSize(width: 40, height: 40)
        exitSprite.colorBlendFactor = 0.1
        exitSprite.position = CGPoint(x: (displayWidth! / 2) - (exitSprite.frame.width / 2 + 10), y: (displayHeight! / 2) - (exitSprite.frame.height / 2) - 10)
        addChild(exitSprite)
        
        // inventory ui button
        shopInventoryButton = SKSpriteNode(imageNamed: "shoulder-bag")
        shopInventoryButton?.name = "ui-inventory-button"
        shopInventoryButton?.size = CGSize(width: 41, height: 41)
        shopInventoryButton?.colorBlendFactor = 0.2
        shopInventoryButton?.position = CGPoint(x: exitSprite.position.x - (exitSprite.frame.width) - 10, y: (displayHeight! / 2) - (shopInventoryButton!.frame.height / 2) - 10)
        addChild(shopInventoryButton!)
        
        // fill shop cells
        fillShopWithCells()
        
        // add buy button
        let buyButtonSprite = SKSpriteNode(color: .blue, size: CGSize(width: 120, height: 45))
        buyButtonSprite.name = "ui-buy-button"
        
        // buy button label
        let buyLabel = SKLabelNode(text: "Купить")
        buyLabel.name = "ui-buy-button-label"
        
        buyButton = buyButtonSprite
        
        buyButtonSprite.position = CGPoint(x: (leftSide?.position.x)!, y: (-(displayHeight! / 2) + buyButtonSprite.frame.height / 2) + 10 )
        buyLabel.fontSize = 16
        buyLabel.verticalAlignmentMode = .center
        buyLabel.fontName = FONTS.AmericanTypewriter
        buyButtonSprite.addChild(buyLabel)
        buyButtonSprite.alpha = 0.8
        self.addChild(buyButtonSprite)
        
        // select first item of the shop initially
        let firstNode = rightSide?.childNode(withName: "cell-square")
        let node = firstNode?.children[0]
        if let item = node?.userData?.value(forKeyPath: "self") as? ShopItem {
            select(touchedNode: node!, selectedItem: item)
        }
        

    }
    
    func fillItemProperties(properties: [Property], done: (_ windowPropsHeight: CGFloat) -> ()) {
        
        
        // clear before filling
        shopItemPropertiesWindow?.removeAllChildren()
        
        var posY: CGFloat = -10
        var fullHeight: CGFloat = 0
        
        // if item has no properties, fill with "no properties" label
        if properties.count == 0 {
            // add "no properties" label
            let noPropsLabel = SKLabelNode(text: "Нет свойств")
            noPropsLabel.position = CGPoint(x: 0, y: posY)
            noPropsLabel.verticalAlignmentMode = .top
            noPropsLabel.name = "no-properties-label"
            noPropsLabel.fontName = FONTS.AmericanTypewriter
            noPropsLabel.fontSize = 12
            noPropsLabel.fontColor = .lightGray
            shopItemPropertiesWindow?.addChild(noPropsLabel)
            return done(noPropsLabel.frame.height + 20)
        }
        var i = 1
        for propery in properties {
            let propDescLabel = SKLabelNode(text: propery.description)
            propDescLabel.verticalAlignmentMode = .top
            
            propDescLabel.fontName = FONTS.AmericanTypewriter
            propDescLabel.fontSize = 12
            // set color
            if propery.positive {
                propDescLabel.fontColor = .green
            } else {
                propDescLabel.fontColor = .red
            }
            propDescLabel.position = CGPoint(x: 0, y: posY)
            posY -= propDescLabel.frame.height
            
            if i != properties.count {
                posY -= propDescLabel.frame.height - 10
                fullHeight += propDescLabel.frame.height + 5
            } else {
                posY -= propDescLabel.frame.height
                fullHeight += propDescLabel.frame.height
            }
            
            shopItemPropertiesWindow?.addChild(propDescLabel)
            i += 1
        }
        return done(fullHeight + 20)
    }
    
    func fillShopWithCells() {
        let squareWidth: CGFloat = 47
        let squareHeight: CGFloat = 47
        
        let leftPadding: CGFloat = 33
        let topPadding: CGFloat = 32
        
        var x = 0 + leftPadding
        var y = 0 - topPadding
        
        let cellsPerRow: Float = 3
        let totalItems: Float = Float(shopItems.count)
        var rowsNum: Float = 1
        
        if floor(totalItems / cellsPerRow) > 1 {
            rowsNum = floor(totalItems / cellsPerRow)
        }
        
        var numItemFilled = 0
        
        // for rows
        for z in 1...Int(rowsNum) {
            
            if z > 1 {
                x = 0 + leftPadding
                y -= squareHeight + 13
            }
            
            // for cells
            for _ in 1...Int(cellsPerRow) {
                let square = SKSpriteNode(color: .clear, size: CGSize(width: squareWidth, height: squareHeight))
                square.name = "cell-square"
                square.anchorPoint = CGPoint(x: 0, y: 1)
                square.position = CGPoint(x: x, y: y)
                
                if numItemFilled < shopItems.count {
                    // shop item image
                    let itemImg = SKSpriteNode(imageNamed:  shopItems[numItemFilled].assetName)
                    itemImg.name = "shopItem-\(shopItems[numItemFilled].assetName)"
                    itemImg.userData = NSMutableDictionary()
                    itemImg.userData?.setValue(shopItems[numItemFilled], forKeyPath: "self")
                    
                    itemImg.position = CGPoint(x: (squareWidth / 2), y: -(squareHeight / 2))
                    initialCellPosY = itemImg.position.y
                    
                    itemImg.size = CGSize(width: squareWidth - 1, height: squareHeight - 1)
                    square.addChild(itemImg)
                }
                
                numItemFilled += 1
                
                rightSide?.addChild(square)
                
                
                x += CGFloat( squareWidth + 45)
            }

        }
    }
    
    func highlightItem(itemNode: SKNode, squareWidth: CGFloat) {
        // clear previous selections
        clearItemSelection()
        
        let selectionWidth = squareWidth + 20
        let bottomSelection = SKSpriteNode(color: .white, size: CGSize(width: selectionWidth, height: 4))
        bottomSelection.alpha = 0.4
        bottomSelection.anchorPoint = CGPoint(x: 0.5, y: 0)
        bottomSelection.position = CGPoint(x: squareWidth / 2, y: -squareWidth)
        bottomSelection.name = "bottom-selection"
        itemNode.addChild(bottomSelection)
    }
    
    func clearItemSelection() {
        for square in rightSide!.children {

            if let selection = square.childNode(withName: "bottom-selection") {
                
                // remove all animations
                square.children[0].removeAllActions()
                selection.removeAllActions()
                
                // set scale back to normal
                selection.parent?.setScale(1.0)
                
                // set position back to normal
                square.children[0].position = CGPoint(x: square.children[0].position.x, y: initialCellPosY!)
                
                // remove selection
                selection.removeFromParent()
                
            }
        }
    }
    
    func exitShopScreen() {
        let missionScene = SKScene(fileNamed: "MissionListScene")
        let transition = SKTransition.fade(with: .black, duration: 1.0)
        let displaySize: CGRect = UIScreen.main.bounds
        // Set the scale mode to scale to fit the window
        missionScene?.scaleMode = .aspectFill
        missionScene?.size = displaySize.size
        self.view?.presentScene(missionScene!, transition: transition)
    }
    
}

