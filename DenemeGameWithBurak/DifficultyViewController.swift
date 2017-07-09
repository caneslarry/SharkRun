//
//  DifficultyViewController.swift
//  JupiterTechs 2017 Copyright (c) all rights reserved.
//
//  Created by emre esen on 13/04/15.
//  
//

import UIKit

class DifficultyViewController: UIViewController {


    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    
    }
    
    
    @IBAction func Back(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: nil)


    }
    
    @IBAction func selectDifficulty(_ sender: AnyObject) {
        
        
        SKTAudio.sharedInstance().playSoundEffect("button_press.wav")
        if let storyboard = storyboard {
            let gameviewController1 = storyboard.instantiateViewController(withIdentifier: "SelectBgViewController") as! SelectBgViewController
            
            

            gameviewController1.SelectBgDifficulty = DiffucultyChoosing(rawValue: sender.tag)!

            
            navigationController?.pushViewController(gameviewController1, animated: true)

            
        }

        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
    }
    
    

}
