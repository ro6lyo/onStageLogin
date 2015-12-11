
import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet var txtUsername : UITextField!
    @IBOutlet var txtPassword : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}

