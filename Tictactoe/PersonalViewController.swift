
import UIKit
import Firebase


class PersonalViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var profileImage: UIImageView!
    
    var info = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        info = logUser.getUserInfo()
        name.text = (info["name"] as? String)!
        
        profileImage.layer.cornerRadius = 50
        profileImage.layer.masksToBounds = true
        //profileImage.image = self.image
        self.view.endEditing(true)
        
        
        
    }
    
    
    //Dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    
}

