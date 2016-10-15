
import UIKit
import Firebase
import AssetsLibrary
import Photos
import PhotosUI
import MobileCoreServices
import CoreData


class SignupDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    var id = ""
    var image = UIImage()
    var filePath = ""
    let fileManager = FileManager.default
    
    
    
    //checkbox
    @IBOutlet weak var Travel: UIButton!
    @IBOutlet weak var Yoga: UIButton!
    @IBOutlet weak var Shooping: UIButton!
    @IBOutlet weak var BBQ: UIButton!
    @IBOutlet weak var Alcohol: UIButton!
    @IBOutlet weak var Cat: UIButton!
    @IBOutlet weak var Hiking: UIButton!
    @IBOutlet weak var Dating: UIButton!
    @IBOutlet weak var Brunch: UIButton!
    
    //checkbox image
    var checkedImage = UIImage(named: "checked")
    var uncheckedImage = UIImage(named: "unchecked")
    
    var isTravel: Bool = false
    var isYoga: Bool = false
    var isShopping:Bool = false
    var isBBQ: Bool = false
    var isAlcohol: Bool = false
    var isCat:Bool = false
    var isHiking: Bool = false
    var isDating: Bool = false
    var isBrunch:Bool = false
    
    
    @IBAction func click1(_ sender: AnyObject) {
        if isTravel == true{
            isTravel = false
            Travel.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        }
        else{
            isTravel = true
            Travel.setBackgroundImage(checkedImage, for: UIControlState.normal)
            
        }
    }
    @IBAction func click2(_ sender: AnyObject) {
        if isDating == true{
            isDating = false
            Dating.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        }
        else{
            isDating = true
            Dating.setBackgroundImage(checkedImage, for: UIControlState.normal)
            
        }
    }
    @IBAction func click3(_ sender: AnyObject) {
        if isYoga == true{
            isYoga = false
            Yoga.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        }
        else{
            isYoga = true
            Yoga.setBackgroundImage(checkedImage, for: UIControlState.normal)
            
        }
    }
    @IBAction func click4(_ sender: AnyObject) {
        if isHiking == true{
            isHiking = false
            Hiking.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        }
        else{
            isHiking = true
            Hiking.setBackgroundImage(checkedImage, for: UIControlState.normal)
            
        }
    }
    @IBAction func click5(_ sender: AnyObject) {
        if isShopping == true{
            isShopping = false
            Shooping.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        }
        else{
            isShopping = true
            Shooping.setBackgroundImage(checkedImage, for: UIControlState.normal)
            
        }
    }
    @IBAction func click6(_ sender: AnyObject) {
        if isBBQ == true{
            isBBQ = false
            BBQ.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        }
        else{
            isBBQ = true
            BBQ.setBackgroundImage(checkedImage, for: UIControlState.normal)
            
        }
    }
    @IBAction func click7(_ sender: AnyObject) {
        if isBrunch == true{
            isBrunch = false
            Brunch.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        }
        else{
            isBrunch = true
            Brunch.setBackgroundImage(checkedImage, for: UIControlState.normal)
            
        }
    }
    @IBAction func click8(_ sender: AnyObject) {
        if isCat == true{
            isCat = false
            Cat.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        }
        else{
            isCat = true
            Cat.setBackgroundImage(checkedImage, for: UIControlState.normal)
            
        }
    }
    @IBAction func click9(_ sender: AnyObject) {
        if isAlcohol == true{
            isAlcohol = false
            Alcohol.setBackgroundImage(uncheckedImage, for: UIControlState.normal)
        }
        else{
            isAlcohol = true
            Alcohol.setBackgroundImage(checkedImage, for: UIControlState.normal)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //将选择的图片保存到Document目录下
        if(id != "" && image != nil){
            
            let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            filePath = "\(rootPath)/selectedImage.jpg"
            let imageData = UIImageJPEGRepresentation(image, 1.0)
            fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnContinue_Click(sender: UIButton){
        
        for i in 0...8 {
            <#code#>
        }
        
        //上传图片
        if(self.id != "" && self.image != nil){
            if (fileManager.fileExists(atPath: filePath)){
                
                let storageRef = FIRStorage.storage().reference().child(id+"*myImage.jpg")
                if let uploadData = UIImagePNGRepresentation(image){
                    storageRef.put(uploadData, metadata:nil, completion:{(metadata, error) in
                        
                        if error != nil {
                            print(error)
                            return
                        }
                        print(metadata)
                        
                        //将图片地址写入数据库
                        let ref = FIRDatabase.database().reference(fromURL: "https://tictactoe-d248f.firebaseio.com/")
                        let usersReference = ref.child("users").child(self.id)
                        let values = ["profileImage": metadata?.downloadURL()]
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
                            }
                        })

                    })
                }
            }
            
            
        }
        print("Sucessfully Upload")
        
        self.performSegue(withIdentifier: "toHomepage", sender: self)
        
    }
    
    
    
    @IBAction func btnSkip_Click(sender: UIButton){
        
        
        
    }
    
}

