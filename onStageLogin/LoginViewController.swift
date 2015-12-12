

import UIKit
import TPKeyboardAvoiding




class LoginViewController: UIViewController,UITextFieldDelegate {
    var scrollView = UIScrollView()
    
    @IBOutlet var txtUsername : UITextField!
    @IBOutlet var txtPassword : UITextField!
    @IBOutlet weak var singInButton: UIButton!
   
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtUsername.layer.cornerRadius = 5.0
        txtUsername.layer.borderWidth = 1.5
        txtUsername.layer.borderColor = UIColor.grayColor().CGColor
        
        singInButton.layer.cornerRadius = 5.0
        singInButton.layer.borderWidth = 1.5
        singInButton.layer.borderColor = UIColor.grayColor().CGColor
        

        
        txtUsername.attributedPlaceholder = NSAttributedString(string:"your@email.com",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        txtPassword.attributedPlaceholder = NSAttributedString(string:"at least 6 characters",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
    }
    
    
    @IBAction func signinTapped(sender : UIButton) {
        
        let username = txtUsername.text!
        let password = txtPassword.text!
        
        urlRecuest(username, password: password)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    
}

