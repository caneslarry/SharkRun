//
//  MainMenuViewController.swift
// JupiterTechs 2017 Copyright (c) all rights reserved.
//

import UIKit
import GameKit
import SpriteKit

class MainMenuViewController: UIViewController,GKGameCenterControllerDelegate {

    var BgTag: Int!
    var QuickPlayRandom:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        if UserDefaults.standard.object(forKey: "totalscore") != nil
        {
            
             Model.sharedInstance.totalscore = UserDefaults.standard.object(forKey: "totalscore") as! Int
            
        }
        
        if UserDefaults.standard.object(forKey: "ADCount") != nil
        {
            
            Model.sharedInstance.ADCount = UserDefaults.standard.object(forKey: "ADCount") as! Int
            
        }
      
        if Model.sharedInstance.sound == true {
            
            SKTAudio.sharedInstance().playBackgroundMusic("Frantic-Gameplay.mp3")
            
        }
        
        
        
        if let storyboard = storyboard {
            _ = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController

       
            
         if  Model.sharedInstance.totalscore > 500
            
        {
            
           QuickPlayRandom = 2
        }
            
         if  Model.sharedInstance.totalscore > 1500
            
        {
            
            QuickPlayRandom = 3
        }
         if  Model.sharedInstance.totalscore > 2500
            
        {
            
            QuickPlayRandom = 4
        }
          if  Model.sharedInstance.totalscore > 3500
            
        {
            
            QuickPlayRandom = 5
        }
         if  Model.sharedInstance.totalscore > 4500
            
        {
            
           QuickPlayRandom = 6
        }
         if  Model.sharedInstance.totalscore > 5500
            
        {
            
            QuickPlayRandom = 7
        }
        
        
        
        }
      
    
        let RandomBg = arc4random() % UInt32(QuickPlayRandom)
         BgTag = Int(RandomBg)
    
      
        authenticateLocalPlayer()
        // Do any additional setup after loading the view.
    }
    
  
    
    @IBAction func RateIt(_ sender: AnyObject) {
        
        var url:URL
        url = URL(string: YourGameLinkOnAppleStore)!
        UIApplication.shared.openURL(url)
       
    }
    

    
    @IBAction func GoInfoPage(_ sender: AnyObject) {
        
        if let storyboard = storyboard {
            let gameviewController1 = storyboard.instantiateViewController(withIdentifier: "InfoPageViewController") as! InfoPageViewController
            navigationController?.pushViewController(gameviewController1, animated: true)
          
        }
        
    }
    //initiate gamecenter
    func authenticateLocalPlayer(){
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.present(viewController!, animated: true, completion: nil)
            }
                
            else {
                //println((GKLocalPlayer.localPlayer().authenticated))
            }
        }
    }
    
    
    @IBAction func goToGameCenter(_ sender: AnyObject) {
        showLeader()
        
    }
    
    
    
    @IBAction func MoreGames(_ sender: AnyObject) {
        
        
        
        var url:URL
        url = URL(string: YourLinkOnAppleStore)!
        UIApplication.shared.openURL(url)
    }
    
    
    
    func showLeader() {
        let vc = self.view?.window?.rootViewController
        let gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        vc?.present(gc, animated: true, completion: nil)
    }
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController)
    {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

    
    func textFieldShouldReturn() -> Bool {
        self.view.endEditing(true)
        return false
    }
    
   
    override var prefersStatusBarHidden : Bool {
        return  true
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        
        
              SKTAudio.sharedInstance().playSoundEffect("button_press.wav")
        if let storyboard = storyboard {
            let gameviewController1 = storyboard.instantiateViewController(withIdentifier: "DifficultyViewController") as! DifficultyViewController
            
            navigationController?.pushViewController(gameviewController1, animated: true)
            
        }


        
        
    }
    

  

}
