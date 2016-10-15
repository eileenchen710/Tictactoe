
import UIKit
import Firebase


class SignupViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var Register: UIButton!
    var id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.endEditing(true)
        
        email.attributedPlaceholder = NSAttributedString(string:"Email",
                                                         attributes:[NSForegroundColorAttributeName: UIColor.white])
        name.attributedPlaceholder = NSAttributedString(string:"Name",
                                                         attributes:[NSForegroundColorAttributeName: UIColor.white])
        password.attributedPlaceholder = NSAttributedString(string:"Password",
                                                            attributes:[NSForegroundColorAttributeName: UIColor.white])
        
        
        
    }
    
    
    //Dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRegister_Click(sender: UIButton){
        
        
        guard let email_  = email.text, let password_ = password.text, let name_ = name.text
            else{
                print("Form is not valid")
                //定义一个弹出框
                let alertView = UIAlertView()
                alertView.delegate = self;
                alertView.message = "Form is not valid"
                alertView.addButton(withTitle: "OK")
                alertView.show()
                return
        }
        
        
        FIRAuth.auth()?.createUser(withEmail: email_, password: password_, completion:{ (user: FIRUser?, error) in
                if error != nil{
                    print(error)
                    //定义一个弹出框
                    let alertView = UIAlertView()
                    alertView.delegate = self;
                    alertView.message = "Form is not valid"
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    return
                }
            
            self.id = (user?.uid)!
            
            guard let uid = user?.uid else{
                return
            }
            
            //successfully authenticated user
            let ref = FIRDatabase.database().reference(fromURL: "https://tictactoe-d248f.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name_, "email": email_]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil{
                    print(err)
                    //定义一个弹出框
                    let alertView = UIAlertView()
                    alertView.delegate = self;
                    alertView.message = "Fail to save into db"
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    return
                }
                else{
                    print("Save user successfully into Firebase db")
                    self.performSegue(withIdentifier: "toPhoto", sender: self)
                }
            })
            
        })
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var nextVC: SignupPhotoViewController = segue.destination as! SignupPhotoViewController
        nextVC.id = id
    
    }
    
}

