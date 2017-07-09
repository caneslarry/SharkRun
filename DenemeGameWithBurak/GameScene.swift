//
//  GameScene.swift
//  JupiterTechs 2017 Copyright (c) all rights reserved.
//
//  This is where all the magic happens.
//  
//

import SpriteKit
import UIKit
import AVFoundation
import AudioToolbox

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    var cointexture : SKTexture!
    var bgTexture : SKTexture!
    var stageParticle : SKEmitterNode!
    var playerEmitter1 = SKEmitterNode()
    var redcointexture : SKTexture!
    var flyherotex1 : SKTexture!
    
    var shieldTexture : SKTexture!
    var shieldItemTexture : SKTexture!
    var coinherotex1 : SKTexture!
    
    var redcoinherotex1 : SKTexture!
    
    var runherotex1 : SKTexture!
    
    var deadherotex1 : SKTexture!
    
    var rocketherotex1 : SKTexture!
    
    var rocketExptex1 : SKTexture!
    
    var Electriclighting1 : SKTexture!
    
    var MineTexture1 : SKTexture!
    var MineTexture2 : SKTexture!
    
    // SKTextures Array for animateWithTextures
    
    var HeroFlyTexturesArray = [SKTexture]()
    var HeroDeathTexturesArray = [SKTexture]()
    var HeroRunTexturesArray = [SKTexture]()
    var CoinTexturesArray = [SKTexture]()
    var RocketTexturesArray = [SKTexture]()
    var RocketExplodeTexturesArray = [SKTexture]()
    var ElectricTexturesArray = [SKTexture]()
    
    

    
    
    
    
    
    // Classes
    var animations = AnimationClass()
    
    
    // Variables
    var moveShipY1 = SKAction()
    var gameover = 0
    var emit = false
    var emitFrameCount = 0
    var maxEmitFrameCount = 30
    var range1 :CGFloat = 0.50
    var playerCurrentPosition = CGPoint() // For Emitter
    var GameviewcontrollerBridge: GameViewController!
    var gSceneBg:BgChoosing!
    var gSceneDifficult:DiffucultyChoosing!
    
    // Timers
    var TimerAddCoin = Timer()
    var TimerAddMine = Timer()
    var TimerAddElectriclighting = Timer()
    var TimerRoketAdd = Timer()
    var TimerRedCoinAdd = Timer()
    var TimerAddShieldItem = Timer()
   
    // BitMasks
    
    var herogroup : UInt32 = 0x1 << 1
    var coingroup : UInt32 = 0x1 << 2
    var redCoinGroup : UInt32 = 0x1 << 4
    var objectgroup : UInt32 = 0x1 << 3
    var groundgroup : UInt32 = 0x1 << 5
    var rocketgroup : UInt32 = 0x1 << 6
    var shieldgroup : UInt32 = 0x1 << 7
    
   
    // LabelNodes
    
    var tabtoplayLabel = SKLabelNode()
    var highscoreLabel = SKLabelNode()
    var highscoreLabel2 = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var stageLabel = SKLabelNode()
    var gameoverLabel = SKLabelNode()
    
    
    // Sprites Objects
    
    var coinobject = SKNode()
    var redCoinObject = SKNode()
    var groundobject = SKNode()
    var shieldObject = SKNode()
    var shieldItemObject = SKNode()
    var movingObject = SKNode()
    var rocketObject = SKNode()
    var gameoverObject = SKNode()
    var emitterObject = SKNode()
    var playerEmitterObject = SKNode()
    var heroobject = SKNode()
    var labelobject = SKNode()
    var bgobject = SKNode()
    
    
    // SpriteNodes
    
    var hero = SKSpriteNode()
    var rocket = SKSpriteNode()
    var coin = SKSpriteNode()
    var redCoin = SKSpriteNode()
    var shield = SKSpriteNode()
    var Electriclighting = SKSpriteNode()
    var Mine = SKSpriteNode()
    var bg = SKSpriteNode()
    var shielditem = SKSpriteNode()
    var ground = SKSpriteNode()
    var sky = SKSpriteNode()
    
    // Sounds
    var ElectricDeadPreload = SKAction()
    var ElectricCreatePreload = SKAction()
    var RocketCreatePreload = SKAction()
    var RocketExplosionPreload = SKAction()
    var BackgroundPreload = SKAction()
    var ShieldOnPreload = SKAction()
    var ShieldOffPreload = SKAction()
    var PickCoinPreload = SKAction()
    var PressBtnPreload = SKAction()
    
    var EatingPreload = SKAction()
  
 
   
   
   
    override func didMove(to view: SKView) {
      //SKTAudio.sharedInstance().pauseBackgroundMusic()
        SKTAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.5
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -0.4)
        
        // background Texture
        
        bgTexture = SKTexture(imageNamed: "BeachStatic.png")
        
        //Emitters
        stageParticle = SKEmitterNode(fileNamed: "StageEmitter.sks")!
        //playerEmitter1 = SKEmitterNode(fileNamed: "engine.sks")!
        
        //Coins Texture
        
        cointexture = SKTexture(imageNamed: "MediumFishBrown.png")
        redcointexture = SKTexture(imageNamed: "MediumFishGreen.png")
        coinherotex1 = SKTexture(imageNamed: "StarfishYellow.png")
        
        redcoinherotex1 = SKTexture(imageNamed: "Starfishred.png")
        
        
        // shields and shield item texture
        
        shieldTexture = SKTexture(imageNamed: "shield.png")
        shieldItemTexture = SKTexture(imageNamed: "shielditem.png")
        
        // Hero textures
        
        flyherotex1 = SKTexture(imageNamed: "shark-swim.png")
        
        
        
        runherotex1 = SKTexture(imageNamed: "shark-swim.png")
        
        
        deadherotex1 = SKTexture(imageNamed: "shark-dead.png")
        
        
        // Rocket Textures
        
        rocketherotex1 = SKTexture(imageNamed: "barrell-red.png")
        
        
        
        
        rocketExptex1 = SKTexture(imageNamed: "Explosion.png")
        
        
        // Electriclight Textures
        
        Electriclighting1 = SKTexture(imageNamed: "Electriclighting0.png")
        
        // Mines Textures
        
        MineTexture1 = SKTexture(imageNamed: "SeaMinesBlue.png")
        MineTexture2 = SKTexture(imageNamed: "SeaMinesGreen.png")
        

        
        
        self.physicsWorld.contactDelegate = self
        
        
        createObjects()
     
        
        if Model.sharedInstance.totalscore > 500 {
            
            Model.sharedInstance.rateBool = true
            
            
        }
        
        if UserDefaults.standard.object(forKey: "highScore") != nil
        {
            Model.sharedInstance.highcore = UserDefaults.standard.object(forKey: "highScore") as! Int
            highscoreLabel.text = "\(Model.sharedInstance.highcore)"
            
            
        }
        
        if UserDefaults.standard.object(forKey: "totalscore") != nil
        {
            
            Model.sharedInstance.totalscore = UserDefaults.standard.object(forKey: "totalscore") as! Int
            
            
        }
       
     
       if gameover == 0 {
           
            CreateGame()
        }
        
       
        self.EatingPreload = SKAction.playSoundFileNamed("chomp-sound.aif", waitForCompletion: false)
        self.PickCoinPreload = SKAction.playSoundFileNamed("chomp-sound.aif", waitForCompletion: false)
        self.ElectricDeadPreload = SKAction.playSoundFileNamed("electricDead.mp3", waitForCompletion: false)
        self.ElectricCreatePreload = SKAction.playSoundFileNamed("electricCreate.wav", waitForCompletion: false)
        self.RocketExplosionPreload = SKAction.playSoundFileNamed("RocketExplosion.wav", waitForCompletion: false)
        self.RocketCreatePreload = SKAction.playSoundFileNamed("RocketCreate.wav", waitForCompletion: false)
        self.ShieldOnPreload = SKAction.playSoundFileNamed("shieldOn.mp3", waitForCompletion: false)
        self.ShieldOffPreload = SKAction.playSoundFileNamed("shieldOff.mp3", waitForCompletion: false)
        
        
        
    
        
    }
    
 
    
    func createObjects()
    {
        
     
        
        // Add all objects to self
        
        self.addChild(movingObject)
        self.addChild(rocketObject)
        self.addChild(coinobject)
        self.addChild(redCoinObject)
        self.addChild(groundobject)
        self.addChild(heroobject)
        self.addChild(labelobject)
        self.addChild(bgobject)
        self.addChild(gameoverObject)
        self.addChild(emitterObject)
        self.addChild(playerEmitterObject)
        self.addChild(shieldObject)
        self.addChild(shieldItemObject)
    }
    
    func CreateGame()
    {
        
        createBg()
        makeground()
        makesky()
        bg.zPosition = -1
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.createhero()
            self.timerfunc()
            //self.AddElectriclighting()
            self.createplayerEmitter()
           
            
        }
        addtaptoplayfunc()
        addstage()
        addscore()
        GameviewcontrollerBridge.soundOnBtn.isHidden = true
        GameviewcontrollerBridge.returnmainmenubutton.isHidden = true
        highscoreLabel2.isHidden = true
        GameviewcontrollerBridge.ShareButton.isHidden = true
        GameviewcontrollerBridge.refreshGameBtn.isHidden = true
        //self.GameviewcontrollerBridge.RestoreiAP.isHidden = true
        GameviewcontrollerBridge.soundOffBtn.isHidden = true
        
       
        if labelobject.children.count != 0
        {
            labelobject.removeAllChildren()
        }
    }
    
    
    func stopTimerFunc()
        
    {
        TimerAddCoin.invalidate()
        TimerAddMine.invalidate()
        TimerAddElectriclighting.invalidate()
        TimerRoketAdd.invalidate()
        TimerRedCoinAdd.invalidate()
        TimerAddShieldItem.invalidate()
        
    }
    
    func addcoin( ){
        var fishIndex = arc4random_uniform(9)
        switch(fishIndex){
        case 0:
            addFish(useimage: String("MediumFishBrown"))
        case 1:
            addFish(useimage: String("MediumFishGreen"))
        case 2:
            addFish(useimage: String("MediumFishPurple"))
        case 3:
            addFish(useimage: String("SmallFishRed"))
        case 4:
            addFish(useimage: String("SmallFishYellow"))
        case 5:
            addFish(useimage: String("SmallFishGreen"))
        case 6:
            addStarFish(useimage: String("StarfishGreen"))
        case 7:
            addStarFish(useimage: String("StarfishRed"))
        case 8:
            addStarFish(useimage: String("StarfishGreen"))
        default:
            addFish(useimage: String("SmallFishGreen"))
        }
    }
    func addFish(useimage imageName: String)
        
    {
        
        coin = SKSpriteNode(texture: cointexture)
        
        CoinTexturesArray = [SKTexture(imageNamed: imageName)]
        
        
        let coinAnimation = SKAction.animate(with: CoinTexturesArray, timePerFrame: 0.1)
        var swimDistanceX = Int32(arc4random_uniform(20))
        var swimDistanceY = Int32(arc4random_uniform(20))
        let swimDirectionX = arc4random_uniform(2)
        let swimDirectionY = arc4random_uniform(2)
       
        
        if (swimDirectionX == 1){
            
            swimDistanceX = swimDistanceX * -1
        }
        if (swimDirectionY == 1){
            
            swimDistanceY = swimDistanceY * -1
        }
        let fishSwim = SKAction.moveBy(x: CGFloat(swimDistanceX), y: CGFloat(swimDistanceY), duration: 0.25)
        let fishSwimBack = SKAction.moveBy(x: CGFloat(swimDistanceX * -1), y: CGFloat(swimDistanceX * -1), duration: 0.25)
        let flyhero = SKAction.repeatForever(SKAction.sequence([coinAnimation,fishSwim,fishSwimBack]))
        coin.run(flyhero)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        coin.size.width = 40
        coin.size.height = 40
        
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.size.width - 20 , height: coin.size.height - 20))
        coin.physicsBody?.restitution = 0
        coin.position = CGPoint(x: self.size.width + 50, y: 0 + cointexture.size().height + 300 + pipeOffset )
        let movecoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatForever(SKAction.sequence([movecoin,removeAction]))
       
        coin.run(dusmanMovebgForever)
        
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coingroup
        coin.zPosition = 1
        coinobject.addChild(coin)
        
        
    }
    func addStarFish(useimage imageName: String)
        
    {
        
        coin = SKSpriteNode(texture: cointexture)
        
        CoinTexturesArray = [SKTexture(imageNamed: imageName)]
        
        
        let coinAnimation = SKAction.animate(with: CoinTexturesArray, timePerFrame: 0.1)
        
       
        
        let flyhero = SKAction.repeatForever(coinAnimation)
        coin.run(flyhero)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        coin.size.width = 40
        coin.size.height = 40
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.size.width - 20 , height: coin.size.height - 20))
        coin.physicsBody?.restitution = 0
        coin.position = CGPoint(x: self.size.width + 50, y: 0 + cointexture.size().height + 300 + pipeOffset )
        let movecoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatForever(SKAction.sequence([movecoin,removeAction]))
        
        coin.run(dusmanMovebgForever)
        
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coingroup
        coin.zPosition = 1
        coinobject.addChild(coin)
        
        
    }
    func addShield()
        
    {
        shield = SKSpriteNode(texture: shieldTexture)
        if Model.sharedInstance.sound == true
            
        {
        run(ShieldOnPreload)
            
        }
        shield.zPosition = 1
        shieldObject.addChild(shield)
        
    }
    
    func addShieldItem()
        
    {
        shielditem = SKSpriteNode(texture: shieldItemTexture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        
        shielditem.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shielditem.size.width - 20 , height: shielditem.size.height - 20))
        shielditem.physicsBody?.restitution = 0
        shielditem.position = CGPoint(x: self.size.width + 50, y: shieldItemTexture.size().height + 300 + pipeOffset)
        let movecoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatForever(SKAction.sequence([movecoin,removeAction]))
        
        shielditem.run(dusmanMovebgForever)
        
        animations.scaleZdirection(shielditem)
        shielditem.setScale(1.1)
        
        shielditem.physicsBody?.isDynamic = false
        shielditem.physicsBody?.categoryBitMask = shieldgroup
        shielditem.zPosition = 1
        shieldItemObject.addChild(shielditem)
        
    }
    
    
    func redCoinAdd() {
        
        redCoin = SKSpriteNode(texture:redcointexture)
        
        CoinTexturesArray = [SKTexture(imageNamed: "MediumFishGreen")]
        
        let coinAnimation1 = SKAction.animate(with: CoinTexturesArray, timePerFrame: 0.1)
        
        let flyhero1 = SKAction.repeatForever(coinAnimation1)
        redCoin.run(flyhero1)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        redCoin.size.width = 40
        redCoin.size.height = 40
        redCoin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.size.width - 10 , height: coin.size.height - 10))
        redCoin.physicsBody?.restitution = 0
        redCoin.position = CGPoint(x: self.size.width + 50, y: 0 + cointexture.size().height + 300 + pipeOffset )
        let movecoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatForever(SKAction.sequence([movecoin,removeAction]))
        
        
        redCoin.run(dusmanMovebgForever)
        //animations.scaleZdirection(redCoin)
        //animations.redColorAnimation(redCoin, animDuration: 0.5)
        redCoin.setScale(1.3)
        redCoin.physicsBody?.isDynamic = false
        redCoin.physicsBody?.categoryBitMask = redCoinGroup
        redCoin.zPosition = 1
        redCoinObject.addChild(redCoin)
        
        
        
    }
    
   
    func createEmitterFunc()
        
    {
        stageParticle = SKEmitterNode(fileNamed: "StageEmitter.sks")!
        stageParticle.position = stageLabel.position
        emitterObject.zPosition = 1
        
        emitterObject.addChild(stageParticle)
    }
    
    func createScoreEmitterFunc()
        
    {
        stageParticle = SKEmitterNode(fileNamed:"StageEmitter.sks")!
        stageParticle.position = scoreLabel.position
        emitterObject.zPosition = 1
        emitterObject.addChild(stageParticle)
        
    }
    
    func createplayerEmitter()
        
    {
       //playerEmitter1 = SKEmitterNode(fileNamed:"engine.sks")!
        //playerEmitterObject.zPosition = 1
        //playerEmitterObject.addChild(playerEmitter1)
        
    }
    
    
    func addHero(_ Herotipi: SKSpriteNode, atPosition position: CGPoint) -> SKSpriteNode {
        
        hero = SKSpriteNode(texture: flyherotex1)
        
        HeroFlyTexturesArray = [SKTexture(imageNamed: "shark-swim"),SKTexture(imageNamed: "shark-swim2"),SKTexture(imageNamed: "shark-swim3")]
        
        let HeroFlyAnimation = SKAction.animate(with: HeroFlyTexturesArray, timePerFrame: 0.08)
        
        hero.position = position
        let flyhero = SKAction.repeatForever(HeroFlyAnimation)
        hero.run(flyhero)
        hero.size.height = 84
        hero.size.width = 120
        hero.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hero.size.width - 40 , height: hero.size.height - 30))
        
        hero.physicsBody?.categoryBitMask = herogroup
        hero.physicsBody?.contactTestBitMask = coingroup | objectgroup | groundgroup|rocketgroup|redCoinGroup|shieldgroup
        hero.physicsBody?.collisionBitMask = groundgroup
        
        hero.physicsBody!.isDynamic = true
        hero.physicsBody?.allowsRotation = false
        hero.zPosition = 1
        
        heroobject.addChild(hero)
        return hero
    }
    
    func addstage()
        
    {
        
        stageLabel.text = "Stage 1"
        stageLabel.position = CGPoint(x: self.frame.maxX - 60, y: self.frame.maxY - 140)
        stageLabel.fontSize = 30
        
        stageLabel.fontColor = UIColor.white
        stageLabel.fontName = "Chalkduster"
        stageLabel.zPosition = 1
        
        self.addChild(stageLabel)
    }
    
    func addtaptoplayfunc()
        
    {
        
        tabtoplayLabel.text = "Tap to start swimming!"
        tabtoplayLabel.position = CGPoint(x: self.frame.midX , y: self.frame.midY)
        tabtoplayLabel.fontSize = 50
        tabtoplayLabel.fontColor = UIColor.white
        tabtoplayLabel.fontName = "Chalkduster"
        tabtoplayLabel.zPosition = 1
        
        self.addChild(tabtoplayLabel)
    }
    
    
    func addscore()
        
    {
        scoreLabel.fontName = "Chalkduster"
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        scoreLabel.fontSize = 60
        
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 1
        
        self.addChild(scoreLabel)
    }
    
    
    func showhighscoreLabelfunc()
    {
        highscoreLabel2.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 150)
        highscoreLabel2.fontSize = 30
        highscoreLabel2.fontName = "Chalkduster"
        highscoreLabel2.fontColor = UIColor.white
        highscoreLabel2.text = "HighScore"
        highscoreLabel2.zPosition = 1
        
        labelobject.addChild(highscoreLabel2)
    }
    
    
    func showhighscore()
        
    {
        
        highscoreLabel = SKLabelNode()
        highscoreLabel.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 210)
        highscoreLabel.fontSize = 50
        highscoreLabel.fontName = "Chalkduster"
        highscoreLabel.fontColor = UIColor.white
        highscoreLabel.isHidden = true
        highscoreLabel.zPosition = 1
        
        labelobject.addChild(highscoreLabel)
        
        
    }
    
    func createhero()
        
    {
        
        
        let heroooo = hero
        
        addHero(heroooo, atPosition: CGPoint(x: self.size.width/4, y: 0 + flyherotex1.size().height + 400))
    }
    
    
    func makeground()
    {
        ground = SKSpriteNode()
        ground.position = CGPoint(x: 0, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: self.frame.size.height / 4 + self.frame.size.height / 8))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = groundgroup
        ground.zPosition = 1
        
        groundobject.addChild(ground)
        
    }
    
    func makesky()
    {
        sky = SKSpriteNode()
        
        sky.position = CGPoint(x: 0, y: self.frame.maxX)
        sky.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width + 100, height: self.frame.size.height - 100))
        sky.physicsBody?.isDynamic = false
        sky.zPosition = 1
        
        movingObject.addChild(sky)
        
    }
    
    
    func createBg()
    {
        switch gSceneBg.rawValue
        {
        case 0:
           bgTexture = SKTexture(imageNamed: "BeachStatic.png")
        case 1:
            bgTexture = SKTexture(imageNamed: "DeepSeaStatic.png")
        case 2:
           bgTexture = SKTexture(imageNamed: "Ocean1Static.png")
        case 3:
            bgTexture = SKTexture(imageNamed: "Ocean2Static.png.png")
        case 4:
           bgTexture = SKTexture(imageNamed: "bg05.png")
        case 5:
            bgTexture = SKTexture(imageNamed: "bg06.png")
        case 6:
           bgTexture = SKTexture(imageNamed: "bg07.png")
        default:
            bgTexture = SKTexture(imageNamed: "bg07.png")
        }
        
        let movebg = SKAction.moveBy(x: -bgTexture.size().width, y: 0, duration: 3)
        
        let replacebg = SKAction.moveBy(x: bgTexture.size().width, y: 0, duration: 0)
        let movebgForever = SKAction.repeatForever(SKAction.sequence([movebg,replacebg]))
        
        
        for i in 0 ..< 3
        {
            
            bg = SKSpriteNode(texture: bgTexture)
            
            bg.position = CGPoint(x: size.width/4 + bgTexture.size().width * CGFloat(i), y: size.height/2)
            bg.size.height = self.frame.height
            bg.run(movebgForever)
            bg.zPosition = 0
            
            bgobject.addChild(bg)
        }
        /**/
        
    }
    
    
    func LevelUp()
    {
        if 1 <= Model.sharedInstance.score && Model.sharedInstance.score < 10
        {
            
            coinobject.speed = 1.05
            redCoinObject.speed = 1.1
            movingObject.speed = 1.05
            rocketObject.speed = 1.05
            self.speed = 1.05
            stageLabel.text = "Stage 1"
            
            
            
        }
        else if  10 <= Model.sharedInstance.score && Model.sharedInstance.score < 16
        {
            
            stageLabel.text = "Stage 2"
            coinobject.speed = 1.1
            redCoinObject.speed = 1.15
            movingObject.speed = -1.1
            rocketObject.speed = 1.1
            
            self.speed = 1.1
            
            
            
        }else if  16 <= Model.sharedInstance.score && Model.sharedInstance.score < 36
        {
            
            
            stageLabel.text = "Stage 3"
            coinobject.speed = 1.15
            redCoinObject.speed = 1.25
            movingObject.speed = 1.15
            rocketObject.speed = 1.15
            
            self.speed = 1.15
            
            
            
        }
        else if 36 <= Model.sharedInstance.score && Model.sharedInstance.score < 60
        {
            
            
            stageLabel.text = "Stage 4"
            coinobject.speed = 1.18
            redCoinObject.speed = 1.28
            movingObject.speed = 1.18
            rocketObject.speed = 1.18
            
            self.speed = 1.18
            
            
            
        } else if 60 <= Model.sharedInstance.score && Model.sharedInstance.score < 80
        {
            
            
            stageLabel.text = "Stage 5"
            coinobject.speed = 1.22
            redCoinObject.speed = 1.32
            movingObject.speed = -1.22
            self.speed = 1.22
            rocketObject.speed = 1.22
            
            
            
            
        } else if 80 <= Model.sharedInstance.score && Model.sharedInstance.score < 150
        {
            
            
            stageLabel.text = "Stage 6"
            coinobject.speed = 1.25
            redCoinObject.speed = 1.35
            movingObject.speed = 1.25
            rocketObject.speed = 1.25
            
            self.speed = 1.25
            
            
            
        } else if 150 <= Model.sharedInstance.score && Model.sharedInstance.score < 190
        {
            
            
            stageLabel.text = "Stage 7"
            coinobject.speed = 1.28
            redCoinObject.speed = 1.38
            movingObject.speed = -1.28
            rocketObject.speed = 1.28
            
            self.speed = 1.28
            
            
            
        } else if 190 <= Model.sharedInstance.score && Model.sharedInstance.score < 300
        {
            
            
            stageLabel.text = "Stage 8"
            coinobject.speed = 1.3
            redCoinObject.speed = 1.35
            movingObject.speed = 1.3
            rocketObject.speed = 1.3
            
            self.speed = 1.3
            
            
            
        } else if 300 <= Model.sharedInstance.score && Model.sharedInstance.score < 500
        {
            
            
            stageLabel.text = "Stage 9"
            coinobject.speed = 1.35
            redCoinObject.speed = 1.40
            movingObject.speed = 1.35
            self.speed = 1.35
            rocketObject.speed = 1.35
            
            
            
            
        } else if 500 <= Model.sharedInstance.score
        {
            
            
            stageLabel.text = "Stage 10"
            coinobject.speed = 1.5
            redCoinObject.speed = 1.60
            movingObject.speed = 1.5
            rocketObject.speed = 1.5
            
            self.speed = 1.5
          
        }
       
    }
    
    func timerfunc()
        
    {
        TimerAddCoin.invalidate()
        TimerAddMine.invalidate()
        TimerAddElectriclighting.invalidate()
        TimerRoketAdd.invalidate()
        TimerRedCoinAdd.invalidate()
        TimerAddShieldItem.invalidate()
        
        TimerAddCoin = Timer.scheduledTimer(timeInterval: 0.62, target: self, selector: #selector(GameScene.addcoin), userInfo: nil, repeats: true)
        TimerRedCoinAdd = Timer.scheduledTimer(timeInterval: 2.246, target: self, selector: #selector(GameScene.redCoinAdd), userInfo: nil, repeats: true)
        
        
        
        switch gSceneDifficult.rawValue
        {
            // easy mode
        case 0:
            
            TimerAddMine = Timer.scheduledTimer(timeInterval: 8.245, target: self, selector: #selector(GameScene.AddMine), userInfo: nil, repeats: true)
            //TimerAddElectriclighting = Timer.scheduledTimer(timeInterval: 10.234, target: self, selector: #selector(GameScene.AddElectriclighting), userInfo: nil, repeats: true)
            TimerRoketAdd = Timer.scheduledTimer(timeInterval: 3.743, target: self, selector: #selector(GameScene.RoketAdd), userInfo: nil, repeats: true)
            
            
            TimerAddShieldItem = Timer.scheduledTimer(timeInterval: 1.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
            
            // medium mode
        case 1:
            
            TimerAddMine = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.AddMine), userInfo: nil, repeats: true)
            //TimerAddElectriclighting = Timer.scheduledTimer(timeInterval: 3.234, target: self, selector: #selector(GameScene.AddElectriclighting), userInfo: nil, repeats: true)
            TimerRoketAdd = Timer.scheduledTimer(timeInterval: 2.743, target: self, selector: #selector(GameScene.RoketAdd), userInfo: nil, repeats: true)
            
            TimerAddShieldItem = Timer.scheduledTimer(timeInterval: 30.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
            
            // hard mode
        case 2:
            
            
            
            TimerAddMine = Timer.scheduledTimer(timeInterval: 2.945, target: self, selector: #selector(GameScene.AddMine), userInfo: nil, repeats: true)
            //TimerAddElectriclighting = Timer.scheduledTimer(timeInterval: 3.034, target: self, selector: #selector(GameScene.AddElectriclighting), userInfo: nil, repeats: true)
            TimerRoketAdd = Timer.scheduledTimer(timeInterval: 2.543, target: self, selector: #selector(GameScene.RoketAdd), userInfo: nil, repeats: true)
            
            TimerAddShieldItem = Timer.scheduledTimer(timeInterval: 40.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
            
            // medium for quick play mode
        default:
            TimerAddMine = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.AddMine), userInfo: nil, repeats: true)
            //TimerAddElectriclighting = Timer.scheduledTimer(timeInterval: 3.234, target: self, selector: #selector(GameScene.AddElectriclighting), userInfo: nil, repeats: true)
            TimerRoketAdd = Timer.scheduledTimer(timeInterval: 2.743, target: self, selector: #selector(GameScene.RoketAdd), userInfo: nil, repeats: true)
            
            TimerAddShieldItem = Timer.scheduledTimer(timeInterval: 30.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
            
            
        }
        
        
    }
    
    func setTimer(_ methodName:String, time:TimeInterval ) -> Timer
        
    {
        let timerset = Timer.scheduledTimer(timeInterval: time, target: self, selector: Selector(methodName), userInfo: nil, repeats: true)
        
        return timerset
    }
    
    
    func AddMine()
    {
        
        Mine = SKSpriteNode(texture: MineTexture1)
        let minesRandom = arc4random() % UInt32(2)
        if minesRandom == 0
        {
            Mine = SKSpriteNode(texture: MineTexture1)
        }else
        {
            Mine = SKSpriteNode(texture: MineTexture2)
            
        }
        Mine.size.width = 70
        Mine.size.height = 62
        Mine.position = CGPoint(x: self.frame.size.width + 150, y: 100+(self.frame.size.height / 4 - self.frame.size.height / 24))
        let moveMayinX = SKAction.moveTo ( x: -self.frame.size.width / 4 , duration: 4)
        Mine.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Mine.size.width - 40 , height: Mine.size.height - 30))
        
        Mine.physicsBody?.categoryBitMask = objectgroup
        
        Mine.physicsBody?.isDynamic = false
        
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatForever(SKAction.sequence([moveMayinX,removeAction]))
        
        
        
        animations.rotateAnimationsToAngle(Mine, animDuration: 0.2)
        Mine.run(dusmanMovebgForever)
        Mine.zPosition = 1
        
        movingObject.addChild(Mine)
    }
    
    
    func RoketAdd()
        
    {
        
        rocket = SKSpriteNode(texture: rocketherotex1)
        rocket.size.width = 71
        rocket.size.height = 100
        
        if Model.sharedInstance.sound == true
            
        {
        run(RocketCreatePreload) // sound
        }
        
        let movementRandom = arc4random() % 8
        if movementRandom == 0 {
            rocket.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 + 220)
        }else if movementRandom == 1
        {
            rocket.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 - 220)
        }else if movementRandom == 2
        {
            rocket.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 + 120)
        }else if movementRandom == 3
        {
            rocket.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 - 120)
        }else if movementRandom == 4
        {
            rocket.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 + 50)
        }
        else if movementRandom == 5
        {
            rocket.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 - 50)
        }
            
        else
            
        {
            rocket.position = CGPoint(x: self.frame.width, y: self.frame.height / 2)
            
        }
        
        let movefuze = SKAction.moveTo( x: -self.frame.size.width / 4 , duration: 4)
        
        RocketTexturesArray = [SKTexture(imageNamed: "barrell-red.png")]
        
        let RocketAnimation = SKAction.animate(with: RocketTexturesArray, timePerFrame: 0.1)
        
        let flyFuze = SKAction.repeatForever(RocketAnimation)
        
        rocket.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rocket.size.width - 20 , height: rocket.size.height - 10))
        
        rocket.physicsBody?.categoryBitMask = rocketgroup
        
        rocket.physicsBody?.isDynamic = false
        
        let maxAspectRatio:CGFloat = 16.0/9.0 // iPhone 5"
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-maxAspectRatioHeight)/2.0
        let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height-playableMargin*2)
        let removeAction = SKAction.removeFromParent()
        let dusmanMovebgForever = SKAction.repeatForever(SKAction.sequence([movefuze,removeAction]))
        
        switch stageLabel.text!
        {
        case "Stage 1":
            range1 = 0.10
            
            
        case "Stage 2":
            range1 = 0.13
            
        case "Stage 3":
            range1 = 0.15
        case "Stage 4":
            range1 = 0.18
            
        case "Stage 5":
            range1 = 0.24
            
        case "Stage 6":
            range1 = 0.28
        case "Stage 7":
            range1 = 0.35
            
        case "Stage 8":
            range1 = 0.40
            
        case "Stage 9":
            range1 = 0.45
        case "Stage 10":
            range1 = 0.50
            
        default:
            range1 = 0.50
            
        }
        
        
        rocket.run(SKAction.repeat(
            
            SKAction.sequence([
                
                SKAction.moveBy(x: 100, y: playableRect.height * range1, duration: 1.0),
                SKAction.moveBy(x: 200, y: -playableRect.height * range1, duration: 1.0)
                ]), count:4
            ))
        
        
        
        rocket.run(dusmanMovebgForever)
        rocket.run(flyFuze)
        
        rocket.zPosition = 1
        
        rocketObject.addChild(rocket)
        
    }
    
    
    func AddElectriclighting()
    {
        if Model.sharedInstance.sound == true
        {
        
        run(ElectricCreatePreload) // Sound
        }
        
        Electriclighting = SKSpriteNode(texture: Electriclighting1)
        
        var scaleValue:CGFloat = 0.3
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 5)
        let scaleRandom = arc4random() % UInt32(5)
        
        if scaleRandom == 1 {scaleValue = 0.9}
        else if scaleRandom == 2 {scaleValue = 0.6}
        else if scaleRandom == 3 {scaleValue = 0.8}
        else if scaleRandom == 4 {scaleValue = 0.7}
        else if scaleRandom == 0 {scaleValue = 1.0}
        
        
        
        let pipeOffset =   self.frame.size.height / 4 + 30 - CGFloat(movementAmount)
        let randomPosition = arc4random() % 2
        Electriclighting.physicsBody?.restitution = 0
        Electriclighting.setScale(scaleValue)
        
        ElectricTexturesArray = [SKTexture(imageNamed: "Electriclighting0"),SKTexture(imageNamed: "Electriclighting1"),SKTexture(imageNamed: "Electriclighting2"),SKTexture(imageNamed: "Electriclighting3")]
        
        let electricAnimation = SKAction.animate(with: ElectricTexturesArray, timePerFrame: 0.1)
        
        let electricAnimationForever = SKAction.repeatForever(electricAnimation)
        
        
        if randomPosition == 0
        {
            
            Electriclighting.position = CGPoint(x: self.size.width + 50, y: 0 + Electriclighting1.size().height/2 + 90 + pipeOffset )
            Electriclighting.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Electriclighting.size.width - 40 , height: Electriclighting.size.height - 20))
        }else
        {
            Electriclighting.position = CGPoint(x: self.size.width + 50, y: self.frame.size.height - Electriclighting1.size().height/2 - 90 - pipeOffset )
            Electriclighting.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Electriclighting.size.width - 40 , height: Electriclighting.size.height - 20))
            
            
            
        }
        
        
        Electriclighting.physicsBody?.isDynamic = false
        let movementRandom = arc4random() % 9
        if movementRandom == 0 {
            moveShipY1 = SKAction.moveTo (y: self.frame.height / 2 + 220 , duration: 4)
        }else if movementRandom == 1
        {
            moveShipY1 = SKAction.moveTo (y: self.frame.height / 2 - 220 , duration: 5)
        }else if movementRandom == 2
        {
            moveShipY1 = SKAction.moveTo (y: self.frame.height / 2 - 150 , duration: 4)
        }else if movementRandom == 3
        {
            moveShipY1 = SKAction.moveTo (y: self.frame.height / 2 + 150 , duration: 5)
        }else if movementRandom == 4
        {
            moveShipY1 = SKAction.moveTo (y: self.frame.height / 2 + 50 , duration: 4)
        }
        else if movementRandom == 5
        {
            moveShipY1 = SKAction.moveTo (y: self.frame.height / 2 - 50 , duration: 5)
        }
            
        else
            
        {
            moveShipY1 = SKAction.moveTo (y: self.frame.height / 2 , duration: 4)
            
        }
        
        let moveAction = SKAction.moveBy(x: -self.frame.width - 300, y: 0, duration: 6)
        
        
        Electriclighting.run(electricAnimationForever)
        Electriclighting.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run() {
                    self.Electriclighting.run(SKAction.rotate(byAngle: π*2, duration:0.5))
                },
                SKAction.wait(forDuration: 20.0)
                ])
            ))
        Electriclighting.run(moveAction)
        Electriclighting.run(moveShipY1)
        Electriclighting.physicsBody?.categoryBitMask = objectgroup
        Electriclighting.zPosition = 1
        movingObject.addChild(Electriclighting)
    }
    
   
    func stopgame()
        
    {
        coinobject.speed = 0
        movingObject.speed = 0
        heroobject.speed = 0
        rocketObject.speed = 0
        
    }
    
    func removeall()
        
    {
        
      

        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        
        gameover = 0
        
        if labelobject.children.count != 0
        {
            labelobject.removeAllChildren()
        }
        TimerAddCoin.invalidate()
        TimerAddMine.invalidate()
        TimerAddElectriclighting.invalidate()
        TimerRoketAdd.invalidate()
        TimerRedCoinAdd.invalidate()
        TimerAddShieldItem.invalidate()
        
       
        
       

        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        self.view?.removeFromSuperview()
    
        self.view?.presentScene(nil)
        GameviewcontrollerBridge = nil
      
    }
    
    deinit {
    }
    
    
    func reloadgame()
        
    {
       
        
        if Model.sharedInstance.sound == true {
            
            SKTAudio.sharedInstance().resumeBackgroundMusic()
            
        }
        
        coinobject.removeAllChildren()
        emitterObject.removeAllChildren()
        gameoverObject.removeAllChildren()
        gameoverObject.removeFromParent()
        stageLabel.text = "Stage 1"
        gameover = 0
        scene?.isPaused = false
        
        movingObject.removeAllChildren()
        rocketObject.removeAllChildren()
        heroobject.removeAllChildren()
        coinobject.speed = 1
        heroobject.speed = 1
        movingObject.speed = 1
        rocketObject.speed = 1
        self.speed = 1
        
        gameoverLabel.isHidden = true
        if labelobject.children.count != 0
        {
            labelobject.removeAllChildren()
        }
        makeground()
        makesky()
        createhero()
        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        //createplayerEmitter()
        GameviewcontrollerBridge.returnmainmenubutton.isHidden = true
        GameviewcontrollerBridge.soundOnBtn.isHidden = true
        GameviewcontrollerBridge.pauseButton.isHidden = false
        GameviewcontrollerBridge.MoveDown.isHidden = false
        GameviewcontrollerBridge.MoveUp.isHidden = false
        stageLabel.isHidden = false
        highscoreLabel2.isHidden = true
        GameviewcontrollerBridge.ShareButton.isHidden = true
        showhighscore()
        TimerAddCoin.invalidate()
        TimerAddMine.invalidate()
        TimerAddElectriclighting.invalidate()
        TimerRoketAdd.invalidate()
        TimerRedCoinAdd.invalidate()
        TimerAddShieldItem.invalidate()
        
        timerfunc()
        
        
        
        
    }
    
    func addgameovertext()
    {
        gameoverLabel = SKLabelNode()
        gameoverLabel.text = "GAME OVER"
        gameoverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        gameoverLabel.fontSize = 50
        gameoverLabel.fontName = "MarkerFelt-Wide"
        gameoverLabel.fontColor = UIColor.red
        self.addChild(gameoverLabel)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        let RocketNode = contact.bodyA.categoryBitMask == rocketgroup ? contact.bodyA.node : contact.bodyB.node
        let objectNode = contact.bodyA.categoryBitMask == objectgroup ? contact.bodyA.node : contact.bodyB.node
        
        if Model.sharedInstance.score > Model.sharedInstance.highcore
        {
            Model.sharedInstance.highcore = Model.sharedInstance.score
        }
        
        UserDefaults.standard.set(Model.sharedInstance.highcore, forKey: "highScore")
        
        highscoreLabel2 = SKLabelNode()
        
        if contact.bodyA.categoryBitMask == objectgroup || contact.bodyB.categoryBitMask == objectgroup
        {
            hero.physicsBody?.velocity = CGVector(dx: 0 , dy: 0)
            
            
            
          
            
            
            
            if Model.sharedInstance.shieldBool == false
            {
                shakeAndFlashAnimation()
                
            
                
                // set highscore for Gamecenter
                
                if Model.sharedInstance.sound == true
                {
                run(ElectricDeadPreload) // sound
                }
                
                playerEmitterObject.removeAllChildren()
                emitterObject.removeAllChildren()
                
                Model.sharedInstance.totalscore = Model.sharedInstance.totalscore + Model.sharedInstance.score
                GameviewcontrollerBridge.saveHighscore()
                
                
          
                
                hero.physicsBody?.allowsRotation = false
                
                
             
                
                
                self.coinobject.removeAllChildren()
                self.redCoinObject.removeAllChildren()
                self.groundobject.removeAllChildren()
                self.shieldObject.removeAllChildren()
                self.movingObject.removeAllChildren()
                self.rocketObject.removeAllChildren()
                self.shieldItemObject.removeAllChildren()
                self.emitterObject.removeAllChildren()
                
                Model.sharedInstance.ShieldAddBool = false
                self.stopgame()
                
                TimerAddCoin.invalidate()
                TimerAddMine.invalidate()
                TimerAddElectriclighting.invalidate()
                TimerRoketAdd.invalidate()
                TimerRedCoinAdd.invalidate()
                TimerAddShieldItem.invalidate()
                
                HeroDeathTexturesArray = [SKTexture(imageNamed: "shark-dead"),SKTexture(imageNamed: "shark-dead2")]
                
                let herodDeathAnimation = SKAction.animate(with: HeroDeathTexturesArray, timePerFrame: 0.2)
                
                
                hero.run(herodDeathAnimation)
                showhighscore()
                gameover = 1
                
                
                
                let delayTime = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    
                    self.scene?.isPaused = true
                    
                    
                    
                    self.heroobject.removeAllChildren()
                    self.showhighscoreLabelfunc()
                    
                    
                    if Model.sharedInstance.sound == true
                    {
                        self.GameviewcontrollerBridge.soundOnBtn.isHidden = false // ses kapalı
                        self.GameviewcontrollerBridge.soundOffBtn.isHidden = true
                        
                    }else
                        
                    {
                        self.GameviewcontrollerBridge.soundOffBtn.isHidden = false
                        self.GameviewcontrollerBridge.soundOnBtn.isHidden = true
                        
                    }
                    
                    self.GameviewcontrollerBridge.refreshGameBtn.isHidden = false
                    self.GameviewcontrollerBridge.returnmainmenubutton.isHidden = false
                    self.GameviewcontrollerBridge.pauseButton.isHidden = true
                    self.GameviewcontrollerBridge.resumeButton.isHidden = true
                    self.GameviewcontrollerBridge.MoveUp.isHidden = true
                    self.GameviewcontrollerBridge.MoveDown.isHidden = true
                    
                    self.stageLabel.isHidden = true
                  
                    
                    if Model.sharedInstance.score > Model.sharedInstance.highcore
                    {
                        Model.sharedInstance.highcore = Model.sharedInstance.score
                    }
                    self.highscoreLabel.isHidden = false
                    self.highscoreLabel2.isHidden = false
                    self.GameviewcontrollerBridge.ShareButton.isHidden = false
                    self.highscoreLabel.text = "\(Model.sharedInstance.highcore)"
                    
                    
                    
                    Model.sharedInstance.ADCount = Model.sharedInstance.ADCount + 1
                    UserDefaults.standard.set(Model.sharedInstance.ADCount, forKey: "ADCount")
                    
                    
                        if Model.sharedInstance.ADCount >= Show_AdMobAd_TimePerFinishGame
                            
                        {
                            
                            let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                                
                                if AdMob_Enabled == true
                                {
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "kDisplayInterstitialNotification"), object: nil)
                                    
                                    Model.sharedInstance.ADCount = 0
                                    UserDefaults.standard.set(Model.sharedInstance.ADCount, forKey: "ADCount")
                                }
                                
                                
                                
                            }
                        }
                    
                    
                  
                    
                }
                
                
                SKTAudio.sharedInstance().pauseBackgroundMusic()
            }else
                
            {
                objectNode?.removeFromParent()
                
                shieldObject.removeAllChildren()
                Model.sharedInstance.shieldBool = false
                if Model.sharedInstance.sound == true
                    
                {
              run(ShieldOffPreload)
                }
            }
            
        }
        
        if contact.bodyA.categoryBitMask == rocketgroup || contact.bodyB.categoryBitMask == rocketgroup {
            hero.physicsBody?.velocity = CGVector(dx: 0 , dy: 0)
            
            
            if Model.sharedInstance.shieldBool == false
            {
                if  gameover == 0
                {
                    
                 
                    
                        shakeAndFlashAnimation()
                 
                    GameviewcontrollerBridge.saveHighscore()
                    if Model.sharedInstance.sound == true
                        
                    {
                 run(RocketExplosionPreload)
                    }
                    
                    Model.sharedInstance.totalscore = Model.sharedInstance.totalscore + Model.sharedInstance.score
                    
           
                    RocketExplodeTexturesArray = [SKTexture(imageNamed: "Explosion"),SKTexture(imageNamed: "Explosion2"),SKTexture(imageNamed: "Explosion3"),SKTexture(imageNamed: "Explosion4"),SKTexture(imageNamed: "Explosion5"),SKTexture(imageNamed: "Explosion6"),SKTexture(imageNamed: "Explosion7")]
                    
                    let RocketExplodeAnimation = SKAction.animate(with: RocketExplodeTexturesArray, timePerFrame: 0.05)
                    
                    let RocketExp = SKAction.repeatForever(RocketExplodeAnimation)
                    
                    
                    RocketNode?.run(RocketExp)
                    
                    
                    playerEmitterObject.removeAllChildren()
                    emitterObject.removeAllChildren()
                    
                    
                    
                    
                    
                    self.coinobject.removeAllChildren()
                    self.movingObject.removeAllChildren()
                    self.shieldItemObject.removeAllChildren()
                    
                    TimerAddCoin.invalidate()
                    TimerAddMine.invalidate()
                    TimerAddElectriclighting.invalidate()
                    TimerRoketAdd.invalidate()
                    TimerRedCoinAdd.invalidate()
                    TimerAddShieldItem.invalidate()// redCoin
                    
                    HeroDeathTexturesArray = [SKTexture(imageNamed: "shark-dead"),SKTexture(imageNamed: "shark-dead2")]
                    
                    let herodDeathAnimation = SKAction.animate(with: HeroDeathTexturesArray, timePerFrame: 0.2)
                    
                    
                    hero.run(herodDeathAnimation)
                    
                    showhighscore()
                    gameover = 1
                    
                    
                    let delayTime = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: delayTime) {
                        
                        self.scene?.isPaused = true
                        
                        self.heroobject.removeAllChildren()
                        self.showhighscoreLabelfunc()
                        
                        if Model.sharedInstance.sound == true
                        {
                            self.GameviewcontrollerBridge.soundOnBtn.isHidden = false // ses kapalı
                            self.GameviewcontrollerBridge.soundOffBtn.isHidden = true
                            
                        }else
                        {
                            self.GameviewcontrollerBridge.soundOffBtn.isHidden = false
                            self.GameviewcontrollerBridge.soundOnBtn.isHidden = true
                            
                        }
                        
                        self.GameviewcontrollerBridge.refreshGameBtn.isHidden = false
                        self.GameviewcontrollerBridge.returnmainmenubutton.isHidden = false
                        self.GameviewcontrollerBridge.pauseButton.isHidden = true
                        self.GameviewcontrollerBridge.resumeButton.isHidden = true
                        self.GameviewcontrollerBridge.MoveUp.isHidden = true
                        self.GameviewcontrollerBridge.MoveDown.isHidden = true
                        self.stageLabel.isHidden = true
                        
                        
                        
                        if Model.sharedInstance.score > Model.sharedInstance.highcore
                        {
                            Model.sharedInstance.highcore = Model.sharedInstance.score
                        }
                        self.highscoreLabel.isHidden = false
                        
                        
                        
                        
                        
                        self.highscoreLabel2.isHidden = false
                        self.GameviewcontrollerBridge.ShareButton.isHidden = false
                        self.highscoreLabel.text = "\(Model.sharedInstance.highcore)"
                        Model.sharedInstance.ShieldAddBool = false
                        
                        
                        self.stopgame()
                        
                     
                        
                        Model.sharedInstance.ADCount = Model.sharedInstance.ADCount + 1
                        UserDefaults.standard.set(Model.sharedInstance.ADCount, forKey: "ADCount")
                        
                        
                        
                        if Model.sharedInstance.ADCount >= Show_AdMobAd_TimePerFinishGame
                            
                        {
                            
                            let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                                
                                if AdMob_Enabled == true
                                {
                                    NotificationCenter.default.post(name: Notification.Name(rawValue: "kDisplayInterstitialNotification"), object: nil)
                                    
                                    Model.sharedInstance.ADCount = 0
                                    UserDefaults.standard.set(Model.sharedInstance.ADCount, forKey: "ADCount")
                                }
                                
                                
                                
                            }
                        }

                        
                        
                    }
                 
                    
                    SKTAudio.sharedInstance().pauseBackgroundMusic()
                    
                    
                }
            }else
            {
                RocketNode?.removeFromParent()
                shieldObject.removeAllChildren()
                Model.sharedInstance.shieldBool = false
                if Model.sharedInstance.sound == true
                    
                {
                run(ShieldOffPreload)
                }
            }
            
            
            
        }
        
        
        
        
        
        if contact.bodyA.categoryBitMask == groundgroup || contact.bodyB.categoryBitMask == groundgroup {
            
            if  gameover == 0
            {
                
                playerEmitter1.isHidden = true

                HeroRunTexturesArray = [SKTexture(imageNamed: "shark-swim"),SKTexture(imageNamed: "shark-swim2"),SKTexture(imageNamed: "shark-swim3")]
                
                let heroRunAnimation = SKAction.animate(with: HeroRunTexturesArray, timePerFrame: 0.1)
                
                let HeroWalk = SKAction.repeatForever(heroRunAnimation)
                
                hero.run(HeroWalk)
            }
            
            
            
        }
        
        
        if contact.bodyA.categoryBitMask == shieldgroup || contact.bodyB.categoryBitMask == shieldgroup{
            LevelUp()
            let shieldNode = contact.bodyA.categoryBitMask == shieldgroup ? contact.bodyA.node : contact.bodyB.node
            
            if Model.sharedInstance.shieldBool == false {
                if Model.sharedInstance.sound == true
                    
                {
                run(PickCoinPreload)
                }
                
                shieldNode?.removeFromParent()
                addShield()
                Model.sharedInstance.shieldBool = true
            }
            
            
        }
        
        
        
        
        if contact.bodyA.categoryBitMask == coingroup || contact.bodyB.categoryBitMask == coingroup{
            LevelUp()
            let coinNode = contact.bodyA.categoryBitMask == coingroup ? contact.bodyA.node : contact.bodyB.node
            if Model.sharedInstance.sound == true
                
            {
            run(EatingPreload)
            }
         
            
            switch stageLabel.text!
            {
           
            case "Stage 1":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 1
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                }
                
                
            case "Stage 2":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                
            case "Stage 3":
                
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                }
                
            case "Stage 4":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                
            case "Stage 5":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 7
                }
                
            case "Stage 6":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 7
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
            case "Stage 7":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 7
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 9
                }
                
            case "Stage 8":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 9
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                
            case "Stage 9":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 9
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 11
                }
            case "Stage 10":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 11
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                
            default:
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 11
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                
            }
            scoreLabel.text = "\(Model.sharedInstance.score)"
            
            
            
            
            
            coinNode?.removeFromParent()
            
            
            
        }
        
        
        if contact.bodyA.categoryBitMask == redCoinGroup || contact.bodyB.categoryBitMask == redCoinGroup{
            LevelUp()
            let redCoinNode = contact.bodyA.categoryBitMask == redCoinGroup ? contact.bodyA.node : contact.bodyB.node
            if Model.sharedInstance.sound == true
                
            {
            run(EatingPreload)
            }
            
            switch stageLabel.text!
            {
                
            case "Stage 1":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                
                
            case "Stage 2":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                
            case "Stage 3":
                
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 6
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                
            case "Stage 4":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 8
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                
            case "Stage 5":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 10
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 14
                }
                
            case "Stage 6":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 12
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 14
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 16
                }
            case "Stage 7":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 14
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 16
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 18
                }
                
            case "Stage 8":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 16
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 18
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 20
                }
                
            case "Stage 9":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 18
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 20
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 22
                }
            case "Stage 10":
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 20
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 22
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 24
                }
                
            default:
                if gSceneDifficult.rawValue == 0
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 20
                }
                else if gSceneDifficult.rawValue == 1
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 22
                }
                else if gSceneDifficult.rawValue == 2
                {
                    Model.sharedInstance.score = Model.sharedInstance.score + 24
                }
                
                
                
            }
            
            scoreLabel.text = "\(Model.sharedInstance.score)"
            
            
            redCoinNode?.removeFromParent()
            
            
            
        }
        
        
        UserDefaults.standard.set(Model.sharedInstance.totalscore, forKey: "totalscore")
        
        
    }
    
    
    func shakeAndFlashAnimation() {
        
        let aView = UIView(frame: self.view!.frame)
        aView.backgroundColor = UIColor.white
        self.view!.addSubview(aView)
        
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            aView.alpha = 0.0
            }, completion: { (done) -> Void in
                aView.removeFromSuperview()
        })
        
        //Shake animation
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        anim.values = [
            NSValue( caTransform3D:CATransform3DMakeTranslation(-15, 5, 5 ) ),
            NSValue( caTransform3D:CATransform3DMakeTranslation( 15, 5, 5 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 7/100
        
        self.view!.layer.add( anim, forKey:nil )
        
    }
    
    // TOUCH ACTIONS!!!!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
       playerEmitter1.isHidden = false
        
        if gameover == 0 {
            
            if tabtoplayLabel.isHidden == false
            {
                tabtoplayLabel.isHidden = true
            }
            
            //hero.physicsBody?.velocity = CGVector(dx: 0 , dy: 0)
            
            //hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
        
            if  gameover == 0
            {
                
                HeroFlyTexturesArray = [SKTexture(imageNamed: "shark-swim"),SKTexture(imageNamed: "shark-swim2"),SKTexture(imageNamed: "shark-swim3")]
                
                let HeroFlyAnimation = SKAction.animate(with: HeroFlyTexturesArray, timePerFrame: 0.1)
                
                let flyhero = SKAction.repeatForever(HeroFlyAnimation)
                hero.run(flyhero)
            }
            
            
        }
        
        
        
    }
    
    override func didFinishUpdate() {
        //playerEmitter1.position = hero.position - CGPoint(x: 30, y: 5)
        shield.position = hero.position + CGPoint(x: 40, y: 5)
        }
    
  
    
    
   
}
