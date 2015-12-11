//
//  ViewController.swift
//  onStageLogin
//
//  Created by Paulina Simeonova on 12/11/15.
//  Copyright © 2015 ro6lyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var usernameLabel : UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userId: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            self.usernameLabel.text = prefs.valueForKey("USERNAME") as? String
            self.userId.text = prefs.valueForKey("ID") as? String
            self.userLocation.text = prefs.valueForKey("COUNTRY") as? String
            
        }
    }
    
    @IBAction func logoutTapped(sender : UIButton) {
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        self.performSegueWithIdentifier("goto_login", sender: self)
    }
}



