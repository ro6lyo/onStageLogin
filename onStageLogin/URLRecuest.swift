
import Alamofire
import Foundation
import UIKit

extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
}

func urlRecuest(username:String, password:String) {
    
    if username.isEmail == false || password.characters.count < 6 {
        
        displayMyAlertMessage("Please enter Valid Username and Password")
    }
    else {
        
    Alamofire.request(.POST, "http://de.staging.onstage.io/api/auth/sign_in", parameters: ["sign_in_username_email": username,
        "sign_in_password": password])
        .responseJSON { response in
            
            print(response.result.error)
            if response.result.error != nil {
                displayMyAlertMessage((response.result.error?.localizedDescription)!)
            }
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                let success:NSInteger = JSON["status"]!!["success"] as! NSInteger
                
                if(success == 1)
                {
                    print("Login SUCCESS");
                    
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    prefs.setObject(JSON["account"]!!["fullname"], forKey: "USERNAME")
                   // prefs.setObject(JSON["account"]!!["country"], forKey: "COUNTRY")
                   // prefs.setObject(JSON["account"]!!["account_id"], forKey: "ID")
                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    
                    
                    var topController = UIApplication.sharedApplication().keyWindow!.rootViewController! as UIViewController
                    
                    while ((topController.presentedViewController) != nil) {
                        topController = topController.presentedViewController!;
                    }
                    
                    topController.dismissViewControllerAnimated(true, completion: nil)
                }
                    
                else {
                    var error_msg:NSString
                    if JSON["status"]!!["message"] as? NSString != nil {
                        error_msg = JSON["status"]!!["message"] as! NSString
                    } else {
                        error_msg = "Unknown Error"
                    }
                    displayMyAlertMessage(error_msg as String)
                }
            }
        }
    }
}


func displayMyAlertMessage(userMessage:String) {
    
    var topController = UIApplication.sharedApplication().keyWindow!.rootViewController! as UIViewController
    
    while ((topController.presentedViewController) != nil) {
        topController = topController.presentedViewController!;}
    
    let alert = UIAlertController(title: "Sign in Failed!", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
    topController.presentViewController(alert, animated:true, completion:nil)
}

