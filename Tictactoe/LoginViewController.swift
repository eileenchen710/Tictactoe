

import UIKit
import Firebase
import FirebaseDatabase
import AssetsLibrary
import Photos
import PhotosUI

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var Register: UIButton!
    @IBOutlet var Login: UIButton!
    var id = ""
    var name = ""
    var useremail = ""
    var interest = ""
    var profileImage = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.view.endEditing(true)
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
                
                //加载用户信息
                self.id = (user?.uid)!
                
                guard let uid = user?.uid else{
                    return
                }
                //把Firebase内容读进变量
                FIRDatabase.database().reference().child("users").child(self.id).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject]{
                        self.name = (dictionary["name"] as? String)!
                        self.useremail = (dictionary["email"] as? String)!
                        self.interest = (dictionary["interest"] as? String)!
                        self.profileImage = (dictionary["profileImage"] as? String)!
                        
                        
                        //下载图片到本地
                        let url = URL(string: self.profileImage)
                        let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: {(data, response, error) in
                            //download hit an error so lets return out
                            if error != nil{
                                print(error)
                                return
                            }
                            //下载图片
                            DispatchQueue.main.async(execute: {
                                print(data?.description)
                                self.saveImageFile(image: UIImage(data: data!)!, path: self.fileInDocumentsDirectory(filename: self.id+"***profileImage"))
                                
                                //初始化用户信息
                                logUser.initUserInfo(name: self.name, email: self.useremail, ID:self.id, interest: self.interest, profileImage: self.profileImage)
                                
                                //跳转页面
                                self.performSegue(withIdentifier: "mainapp", sender: self)
                                
                                
                            })
                            
                            
                        })
                        task.resume()
                        
                        
                    }
                    }, withCancel: nil)
                
                
                //读取所有activities
                let ref = FIRDatabase.database().reference().child("activity")
                ref.observe(.childAdded, with: { (snapshot) in
                    print(snapshot)
                    
                    if let dictionary = snapshot.value as? [String: AnyObject]{
                        
                        let imagePath = (dictionary["image"] as? String)!
                        let localPath = self.fileInDocumentsDirectory(filename: (dictionary["creatTime"] as? String)!)
                        
                        //下载图片到本地
                        let url = URL(string: imagePath)
                        let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: {(data, response, error) in
                            //download hit an error so lets return out
                            if error != nil{
                                print(error)
                                return
                            }
                            //下载图片
                            DispatchQueue.main.async(execute: {
                                print(data?.description)
                                
                                self.saveImageFile(image: UIImage(data: data!)!, path: localPath)
                                print("save in localPath:"+localPath.absoluteString)
                                
                            })
                            
                            
                        })
                        task.resume()
                        
                    }
                    
                    }, withCancel: nil)
                
            
                
            }
        })
    }
    
    //save image to file
    func saveImageFile(image: UIImage, path: URL) -> Bool{
        // let ImageData = UIImagePNGRepresentation(image)
        let ImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        try? ImageData?.write(to: path)
        return true
        
    }
    // Get the documents Directory
    
    func documentsDirectory() -> URL {
        let documentsFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsFolderPath
    }
    // Get path for a file in the directory
    
    func fileInDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
    


    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    //Dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

