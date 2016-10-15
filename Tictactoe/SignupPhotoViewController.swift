
import UIKit
import Firebase
import AssetsLibrary
import Photos
import PhotosUI
import MobileCoreServices
import CoreData

class SignupPhotoViewController: UIViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
    var id = ""
    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(id)
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
            imageView.layer.cornerRadius = 105
            imageView.layer.masksToBounds = true
            imageView.image = selectedImage
            
            self.image = selectedImage
        }
        
        
        //图片控制器退出
        picker.dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func btnContinue_Click(sender: UIButton){
        self.performSegue(withIdentifier: "toDetail", sender: self)
    }

    
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var nextVC2: SignupDetailViewController = segue.destination as! SignupDetailViewController
        nextVC2.id = id
        nextVC2.image = self.image
        
    }
    
    
    
    
}

