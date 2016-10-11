

import UIKit
import Firebase
import FirebaseDatabase


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var Register: UIButton!
    @IBOutlet var Login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        email.attributedPlaceholder = NSAttributedString(string:"Email",
                                                             attributes:[NSForegroundColorAttributeName: UIColor.white])
        password.attributedPlaceholder = NSAttributedString(string:"Password",
                                                         attributes:[NSForegroundColorAttributeName: UIColor.white])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRegister_Click(sender: UIButton){
        
        
        
    }
    
    @IBAction func login(_ sender: AnyObject) {
        
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: {
            user, Error in
            if Error != nil {
                print("Incorrect")
            }
            else{
                print("success")
                self.performSegue(withIdentifier: "mainapp", sender: self)
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    
    
}

