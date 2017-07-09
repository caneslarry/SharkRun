//
//  GameViewController.swift
//  JupiterTechs 2017 Copyright (c) all rights reserved.
//
//  Created by emre esen on 06/02/15.
//  
//

import UIKit
import SpriteKit
import GameKit
import Social
import StoreKit
import GoogleMobileAds

extension SKNode {
    class func unarchiveFromFile(_ file : NSString) -> SKNode? {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController,SKProductsRequestDelegate,SKPaymentTransactionObserver,GADInterstitialDelegate

{

    @IBOutlet weak var RemoveAdsBtn: UIButton!
    @IBOutlet weak var returnmainmenubutton: UIButton!
    @IBOutlet weak var soundOnBtn: UIButton!
    @IBOutlet weak var soundOffBtn: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pauseLabel: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var refreshGameBtn: UIButton!
    @IBOutlet weak var RestoreiAP: UIButton!
    

    @IBOutlet weak var MoveUp: UIButton!
    
    @IBOutlet weak var MoveDown: UIButton!

    @IBOutlet weak var LoadingView: UIView!
    
    
    
    
    // Variables
    var highscore = 0
    var control:Int!
    var gVBgChoosing:BgChoosing!
    var gVDifficulty:DiffucultyChoosing!
    var endgamebuton = false
    var scene = GameScene(size:CGSize(width: 1024, height: 768))
    
    var uptimer:Timer!
    var downtimer:Timer!
    
    // Admob
    var AdMobID:String!
    var Interstitial:GADInterstitial?
    
   let textureAtlas = SKTextureAtlas(named: "scene.atlas")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        
        LoadingView.isHidden = false
        SwiftSpinner.show("Loading...", animated: true)
        
       
        
        SKPaymentQueue.default().add(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.displayInterstitial), name: NSNotification.Name(rawValue: "kDisplayInterstitialNotification"), object: nil)
        
        Interstitial = createAndLoadInterstitial()

        
      
        
        if UserDefaults.standard.object(forKey: "AdMobAdShows") != nil
        {
            
            AdMob_Enabled = UserDefaults.standard.object(forKey: "AdMobAdShows") as! Bool
            
        }
        

            //refreshGameBtn.isHidden = true
            //RestoreiAP.isHidden = true
    
            let skView = self.view as! SKView
            
            skView.ignoresSiblingOrder = true
           // skView.showsNodeCount = true
           // skView.showsFPS = true
            
            /* Set the scale mode to scale to fit the window */
        
            scene.scaleMode = .aspectFill
            scene.gSceneBg = gVBgChoosing
            scene.gSceneDifficult = gVDifficulty
            scene.GameviewcontrollerBridge = self
        
        
        
         self.textureAtlas.preload { () -> Void in
        
        let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
         
           
            self.LoadingView.isHidden = true
                SwiftSpinner.hide()
                
                
            skView.presentScene(self.scene)
               
                
            }
            
            
        }
        
     

    }

    @IBAction func MoveDownNow(_ sender: UIButton) {
        
        //var i = 1;
        //scene.hero.physicsBody?.velocity = CGVector(dx: 0 , dy: 0)
        scene.hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -50))
        
        if #available(iOS 10.0, *) {
            downtimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: swimDown)
        } else {
            // Fallback on earlier versions
        }
        //uptimer.invalidate()

        
    }
    
    func swimUp(_ timer: Timer){
        scene.hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
        
    }
    
    func swimDown(_ timer: Timer){
        scene.hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -50))
    }
    
    @IBAction func StopMovingDownNow(_ sender: UIButton) {
        
        //var i = 1;
        scene.hero.physicsBody?.velocity = CGVector(dx: 0 , dy: -5)
        downtimer.invalidate()
        //scene.hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -50))
    }

    
    @IBAction func MoveUpNow(_ sender: UIButton) {
   
        //scene.hero.physicsBody?.velocity = CGVector(dx: 0 , dy: 0)
        
        scene.hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
        
        if #available(iOS 10.0, *) {
            uptimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: swimUp)
        } else {
            // Fallback on earlier versions
        }

    
    }
    
    @IBAction func StopMovingUpNow(_ sender: UIButton) {
        
        //var i = 1;
        scene.hero.physicsBody?.velocity = CGVector(dx: 0 , dy: 5)
        uptimer.invalidate()

        //scene.hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
    }
    
    
    /*
    @IBAction func moveDownNow(_ sender: UIButton) {
        var i = 1;
    }
   */
    
    @IBAction func RefreshGameFunc(_ sender: UIButton) {
        
        //RELOAD GAME
        //RemoveAdsBtn.isHidden = true
        scene.GameviewcontrollerBridge = self
        scene.reloadgame()
        refreshGameBtn.isHidden = true
        soundOffBtn.isHidden = true
        //RestoreiAP.isHidden = true
        Model.sharedInstance.ShieldAddBool = false

        
    }
 
    
    
    
    @IBAction func pauseAction(_ sender: UIButton) {
         SKTAudio.sharedInstance().playSoundEffect("button_press.wav")
        let scene1 = (self.view as! SKView).scene!
        
        pauseLabel.isHidden = false
        pauseButton.isHidden = true
        resumeButton.isHidden = false
        MoveUp.isHidden = true
        MoveDown.isHidden = true
        scene1.isPaused = true
        scene.stopTimerFunc()
 
        
    }
    
    
    @IBAction func ResumeBtn(_ sender: UIButton)
    {
        
        SKTAudio.sharedInstance().playSoundEffect("button_press.wav")
        let scene1 = (self.view as! SKView).scene!
        
        pauseLabel.isHidden = true
        pauseButton.isHidden = false
        resumeButton.isHidden = true
        MoveUp.isHidden = false
        MoveDown.isHidden = false
        scene1.isPaused = false
        scene.timerfunc()
        
    }


  
    @IBAction func SoundOnFunc(_ sender: AnyObject) {
        
        
        if Model.sharedInstance.sound == true
        {
            
            SKTAudio.sharedInstance().pauseBackgroundMusic()
            
            
            
            Model.sharedInstance.sound = false
            
            soundOnBtn.isHidden = true
            soundOffBtn.isHidden = false
            
        }
        
    }
    
    @IBAction func SoundOffFunc(_ sender: AnyObject) {
        
       
            
        SKTAudio.sharedInstance().resumeBackgroundMusic()
            
        
        soundOnBtn.isHidden = false
        soundOffBtn.isHidden = true
        Model.sharedInstance.sound = true
        
    }
    
    func saveHighscore() {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            
            
            let scoreReporter = GKScore(leaderboardIdentifier: LeaderBoard_ID) //leaderboard id here
            
            scoreReporter.value = Int64(Model.sharedInstance.score) //score variable here (same as above)
            
            let scoreArray: [GKScore] = [scoreReporter]
            /*
            GKScore.report(scoreArray, withCompletionHandler: {(error : NSError?) -> Void in
                if error != nil {
                    print("error")
                }
            })
 */
            
        }
        
    }
    
    // social media publish
    func socialShare(sharingText: String?, sharingImage: UIImage?, sharingURL: URL?) {
        var sharingItems = [AnyObject]()
        
        if let text = sharingText {
            sharingItems.append(text as AnyObject)
        }
        if let image = sharingImage {
            sharingItems.append(image)
        }
        if let url = sharingURL {
            sharingItems.append(url as AnyObject)
        }
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.copyToPasteboard,UIActivityType.airDrop,UIActivityType.addToReadingList,UIActivityType.assignToContact,UIActivityType.postToTencentWeibo,UIActivityType.postToVimeo,UIActivityType.print,UIActivityType.saveToCameraRoll,UIActivityType.postToWeibo]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // social media publish
    @IBAction func publishFB(_ sender: AnyObject) {
        socialShare(sharingText: "This is my score : \(Model.sharedInstance.score)! Beat me :) ", sharingImage: UIImage(named: "Icon-76.png"), sharingURL: URL(string: "https://itunes.apple.com/app/jetpack-challenge-premium/id988154168?mt=8"))
        
    }

    
    @IBAction func returnMainMenu(_ sender: AnyObject) {
        
        
        self.navigationController?.popViewController(animated: false)
        self.navigationController?.dismiss(animated: false, completion: nil)

        
        
            DispatchQueue.main.async(execute: {
            
                
               
                
                Model.sharedInstance.ShieldAddBool = false
                
                self.pauseLabel.isHidden = true
                self.pauseButton.isHidden = true
                self.resumeButton.isHidden = true
                self.scene.removeall()
         
            
            
        })
        
     

        
    }
    
    
    @IBAction func Restore_iAP(_ sender: AnyObject) {
        
        if (SKPaymentQueue.canMakePayments()) {
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
        
        
    }
    
    
    @IBAction func RemoveAds(_ sender: AnyObject) {
        
        buyConsumable()
        
    }
    
    
    func buyConsumable(){
        print("About to fetch the products");
        // We check that we are allow to make the purchase.
        if (SKPaymentQueue.canMakePayments())
        {
            let productID:NSSet = NSSet(object: iAP_ID);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String> );
            productsRequest.delegate = self;
            productsRequest.start();
            print("Fething Products");
        }else{
            print("can't make purchases");
        }
    }
    
    // Helper Methods
    
    func buyProduct(_ product: SKProduct){
        print("Sending the Payment Request to Apple");
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment);
        
    }
    
    
    // Delegate Methods for IAP
    
    func productsRequest (_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("got the request from Apple")
        let count : Int = response.products.count
        if (count>0) {
            let validProduct: SKProduct = response.products[0]
            if (validProduct.productIdentifier == iAP_ID) {
                print(validProduct.localizedTitle)
                print(validProduct.localizedDescription)
                print(validProduct.price)
                buyProduct(validProduct);
            } else {
                print(validProduct.productIdentifier)
            }
        } else {
            print("nothing")
        }
    }
    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])    {
        print("Received Payment Transaction Response from Apple");
    
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .purchased:
                    IAP()
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                case .failed:
                    print("Purchased Failed");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                     case .restored:
                        IAP()
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    SweetAlert().showAlert("Purchased is Restored Successfully")
                    
                default:
                    break;
                }
            }
        }
        
    }
    
    
    func IAP()
    {
        

            AdMob_Enabled = false
            UserDefaults.standard.set(AdMob_Enabled, forKey: "AdMobAdShows")
        
    }
    
    
    func createAndLoadInterstitial()->GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: AdMob_ID)
        
        interstitial?.delegate = self
        
        
        interstitial?.load(GADRequest())
        return interstitial!
    }
    
    
    func interstitial(_ ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        Interstitial = createAndLoadInterstitial()
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial!) {
        Interstitial = createAndLoadInterstitial()
    }
    
    func displayInterstitial() {
        if let _ = Interstitial?.isReady {
            Interstitial?.present(fromRootViewController: self)
        }
    }
    

    
    deinit {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        
        
    }

   
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return UIStatusBarAnimation.fade
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
    
 
  
}
