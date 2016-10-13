
import UIKit
import Firebase


class SignupViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var Register: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        email.attributedPlaceholder = NSAttributedString(string:"Email",
                                                         attributes:[NSForegroundColorAttributeName: UIColor.white])
        name.attributedPlaceholder = NSAttributedString(string:"Name",
                                                         attributes:[NSForegroundColorAttributeName: UIColor.white])
        password.attributedPlaceholder = NSAttributedString(string:"Password",
                                                            attributes:[NSForegroundColorAttributeName: UIColor.white])
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRegister_Click(sender: UIButton){
        
        
        guard let email_  = email.text, let password_ = password.text, let name_ = name.text
            else{
                print("Form is not valid")
                return
        }
        
        
        FIRAuth.auth()?.createUser(withEmail: email_, password: password_, completion:{ (user: FIRUser?, error) in
                if error != nil{
                    print(error)
              //      return
                }
            //successfully authenticated user
            let ref = FIRDatabase.database().reference(fromURL: "https://tictactoe-d248f.firebaseio.com/")
            let usersReference = ref.child("users")
            let values = ["name": name_, "email": email_]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil{
                    print(err)
                    return
                }
                
                print("Save user successfully into Firebase db")
            })
            
        })
        
        
    }
    
}

