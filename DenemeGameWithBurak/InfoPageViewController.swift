//
//  InfoPageViewController.swift
//  JupiterTechs 2017 Copyright (c) all rights reserved.
//
//  Created by emre esen on 14/04/15.
//  
//

import UIKit

class InfoPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePage(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func BackBtn(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        navigationController!.popViewController(animated: true)
    }
 

}
