//
//  URLRecuest.swift
//  onStageLogin
//
//  Created by Paulina Simeonova on 12/11/15.
//  Copyright © 2015 ro6lyo. All rights reserved.
//

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
        
        let post:NSString = "sign_in_username_email=\(username)&sign_in_password=\(password)"
        
        print("PostData: %@",post);
        
        let url:NSURL = NSURL(string:"http://de.staging.onstage.io/api/auth/sign_in")!
        let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        let postLength:NSString = String( postData.length )
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession()
        let task =  session.dataTaskWithRequest(request, completionHandler: {urlData, response, error -> Void in
            
            if error == nil {
                
                let res = response as! NSHTTPURLResponse!;
                print("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {     // status code 200-300
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    print("Response ==> %@", responseData);
                    
                    do {
                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                        
                        let success:NSInteger = jsonData["status"]!["success"] as! NSInteger
                        
                        print("Success: %ld", success);
                        
                        if(success == 1)
                        {
                            print("Login SUCCESS");
                            
                            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            prefs.setObject(jsonData["account"]!["fullname"], forKey: "USERNAME")
                            prefs.setObject(jsonData["account"]!["country"], forKey: "COUNTRY")
                            prefs.setObject(jsonData["account"]!["account_id"], forKey: "ID")
                            
                            
                            prefs.setInteger(1, forKey: "ISLOGGEDIN")
                            prefs.synchronize()
                            
                            
                            var topController = UIApplication.sharedApplication().keyWindow!.rootViewController! as UIViewController
                            
                            while ((topController.presentedViewController) != nil) {
                                topController = topController.presentedViewController!;
                            }
                            
                            topController.dismissViewControllerAnimated(true, completion: nil)
                        }
                            
                        else {
                            // server error
                            var error_msg:NSString
                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Unknown Error"
                            }
                            
                            dispatch_async(dispatch_get_main_queue()) { displayMyAlertMessage(error_msg as String) }
                        }
                        
                    }
                    catch {
                        // catch json parse error
                        dispatch_async(dispatch_get_main_queue()) { displayMyAlertMessage("Connection Failed")}
                    }
                }
                    
                else {
                    //status code 200<>300
                    dispatch_async(dispatch_get_main_queue()) {displayMyAlertMessage("\(res.statusCode)") }
                }
            }
            else {
                // session error
                dispatch_async(dispatch_get_main_queue()) { displayMyAlertMessage("\(error!.localizedDescription)")}
            }
        })
        
        task.resume()
    }
}
func displayMyAlertMessage(userMessage:String){
    
    var topController = UIApplication.sharedApplication().keyWindow!.rootViewController! as UIViewController
    
    while ((topController.presentedViewController) != nil) {
        topController = topController.presentedViewController!;
    }
    
    
    let alert = UIAlertController(title: "Sign in Failed!", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
    topController.presentViewController(alert, animated:true, completion:nil)
}

