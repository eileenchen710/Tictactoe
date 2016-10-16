
import UIKit
import Firebase
import AssetsLibrary
import Photos
import PhotosUI
import MobileCoreServices
import CoreData


class SignupDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    var image = UIImage()
    var filePath = ""
    let fileManager = FileManager.default
    var interest: String = ""
    
    
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
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnContinue_Click(sender: UIButton){
        
        if isTravel == true{
            interest += ",Travel"
        }
        if isDating == true{
            interest += ",Dating"
        }
        if isYoga == true{
            interest += ",Yoga"
        }
        if isHiking == true{
            interest += ",Hiking"
        }
        if isShopping == true{
            interest += ",Shopping"
        }
        if isBBQ == true{
            interest += ",BBQ"
        }
        if isBrunch == true{
            interest += ",Brunch"
        }
        if isCat == true{
            interest += ",Cat"
        }
        if isAlcohol == true{
            interest += ",Alcohol"
        }
        
        let ref = FIRDatabase.database().reference(fromURL: "https://tictactoe-d248f.firebaseio.com/")
        let usersReference = ref.child("users").child(logUser.ID)
        
        //上传兴趣
        if interest != ""{
            
            let value1 = ["interest": self.interest]
            usersReference.updateChildValues(value1)
            
        }
        //写入本地
        logUser.interest = interest
        
        
        
        
        //上传图片
        if(self.image != nil){
            
            if (fileManager.fileExists(atPath: filePath)){
                
                let storageRef = FIRStorage.storage().reference().child(logUser.ID+"*myImage.jpg")
                if let uploadData = UIImagePNGRepresentation(image){
                    storageRef.put(uploadData, metadata:nil, completion:{(metadata, error) in
                        
                        if error != nil {
                            print(error)
                            return
                        }
                        print(metadata)
                        
                        
                        if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                            
                            //将图片地址写入数据库
                            let value2 = ["profileImage": profileImageUrl]
                            usersReference.updateChildValues(value2, withCompletionBlock: { (err, ref) in
                                
                                if err != nil{
                                    print(err)
                                    return
                                }
                                else{
                                    print("Save image successfully into Firebase db")
                                }
                            })
                        }
                    
                    })
                }
            }
            
            
        }
        
        
        
        print("Sucessfully Upload")
        
        self.performSegue(withIdentifier: "toHomepage", sender: self)
        
    }
    
    
    
    
}

