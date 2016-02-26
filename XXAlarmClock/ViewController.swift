//
//  ViewController.swift
//  XXAlarmClock
//
//  Created by Scotty Shaw on 2/5/16.
//  Copyright © 2016 ___sks6___. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {
    
    let isLoggedIn: Bool = true
    
    @IBAction func goToNextView(sender: AnyObject) {
        if (isLoggedIn) {
            self.performSegueWithIdentifier("LoggedInSegue", sender: self)
        }
        else {
            self.performSegueWithIdentifier("NotLoggedInSegue", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "xx_dosequis.png")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

