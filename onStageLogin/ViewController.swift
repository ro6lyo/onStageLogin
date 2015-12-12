//
//  ViewController.swift
//  onStageLogin
//
//  Created by Paulina Simeonova on 12/11/15.
//  Copyright © 2015 ro6lyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet var usernameLabel : UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        logOutButton.layer.cornerRadius = 5.0
        logOutButton.layer.borderWidth = 1.5
        logOutButton.layer.borderColor = UIColor.grayColor().CGColor
    
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            self.usernameLabel.text = prefs.valueForKey("USERNAME") as? String
                       
        }
    }
    
    @IBAction func logoutTapped(sender : UIButton) {
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        self.performSegueWithIdentifier("goto_login", sender: self)
    }
}



