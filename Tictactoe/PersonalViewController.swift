
import UIKit
import Firebase
import FBSDKCoreKit


class PersonalViewController: UIViewController,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var interest1: UIButton!
    @IBOutlet weak var interest3: UIButton!
    @IBOutlet weak var interest4: UIButton!
    @IBOutlet weak var interest2: UIButton!
    @IBOutlet var name: UITextField!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var list : UITableView!
    
    var info = NSDictionary()
    
    var imagePicker = UIImagePickerController()
    var image = UIImage()
    var interest = ""
    
    override func viewWillAppear(_ animated: Bool) {
        info = logUser.getUserInfo()
        name.text = (info["name"] as? String)!
        interest = (info["interest"] as? String)!
        
        
        
        //载入用户头像
        profileImage.image = logUser.loadimage()
        
        profileImage.layer.cornerRadius = 50
        profileImage.layer.masksToBounds = true
        //profileImage.image = self.image
        self.view.endEditing(true)
        
        
        if(interest != ""){
            
            //载入用户兴趣
            let splitedArray = interest.components(separatedBy: ",")
            
            interest1.setTitle(splitedArray[1], for: UIControlState.normal)
            if(splitedArray.count != 1){
                interest2.setTitle(splitedArray[2], for: UIControlState.normal)
                if(splitedArray.count != 2){
                    interest3.setTitle(splitedArray[3], for: UIControlState.normal)
                    if(splitedArray.count != 3){
                        interest4.setTitle(splitedArray[4], for: UIControlState.normal)
                    }
                }
                
            }
            
            
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    
    //Dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnUpload_Click(sender: UIButton){
        
        let actionSheet = UIActionSheet()
        actionSheet.addButton(withTitle: "Cancel")
        actionSheet.addButton(withTitle: "Camera")
        actionSheet.addButton(withTitle: "Photo Library")
        actionSheet.cancelButtonIndex=0
        actionSheet.delegate = self
        actionSheet.show(in: self.view);
        
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        print("点击了："+actionSheet.buttonTitle(at: buttonIndex)!)
        if(buttonIndex == 1){
            //打开相机
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            present(imagePicker, animated: true, completion: nil)
            
        }
        
        if(buttonIndex == 2){
            //打开相册
            //判断设置是否支持图片库
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                //初始化图片控制器
                let picker = UIImagePickerController()
                //设置代理
                picker.delegate = self
                picker.allowsEditing = true
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                //弹出控制器，显示界面
                self.present(picker, animated: true, completion: {
                    () -> Void in
                })
            }else{
                print("读取相册错误")
            }
            
        }
    }
    
    
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //获取选择的图片
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] {
            selectedImageFromPicker = editedImage as? UIImage
        }else if let originalImage = info[UIImagePickerControllerOriginalImage]{
            selectedImageFromPicker = originalImage as? UIImage
        }
        
        
        //将图片载入imageview
        if let selectedImage = selectedImageFromPicker {
            profileImage.layer.cornerRadius = 50
            profileImage.layer.masksToBounds = true
            profileImage.image = selectedImage
            
            self.image = selectedImage
        }
        
        
        //图片控制器退出
        picker.dismiss(animated: true, completion:nil)
    }

    @IBAction func didTapLogout(_ sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        
        FBSDKAccessToken.setCurrent(nil)
        
        
        
        let mianStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController: UIViewController = mianStoryboard.instantiateViewController(withIdentifier: "Login View Controller")
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
}

