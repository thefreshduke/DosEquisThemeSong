//
//  LogInViewController.swift
//  XXAlarmClock
//
//  Created by Scotty Shaw on 2/6/16.
//  Copyright © 2016 ___sks6___. All rights reserved.
//

import UIKit
import TwitterKit

class LogInViewController: UIViewController {
    
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "xx_dosequis.png")!)
        
        let functionSelector: Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: functionSelector, userInfo: nil, repeats: true)
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                print("signed in as \(session!.userName)");
                self.performSegueWithIdentifier("LoggedInSegue", sender: self)
            }
            else {
                print("error: \(error!.localizedDescription)");
            }
        })
        
//        let logInButton = TWTRLogInButton { (session, error) in
//            if let unwrappedSession = session {
//                let alert = UIAlertController(title: "Logged In",
//                    message: "User \(unwrappedSession.userName) has logged in",
//                    preferredStyle: UIAlertControllerStyle.Alert
//                )
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
//            }
//            else {
//                print("wut")
//                NSLog("Login error: %@", error!.localizedDescription);
//            }
//        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime () {
//        print("tick tock")
        print(timer.fireDate)
    }
    
}
