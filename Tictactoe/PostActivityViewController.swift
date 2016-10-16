//
//  PostActivityViewController.swift
//  Tictactoe
//
//  Created by 王益民 on 10/11/16.
//  Copyright © 2016 W&C. All rights reserved.
//


import UIKit
import Firebase
import AssetsLibrary
import Photos
import PhotosUI
import MobileCoreServices
import CoreData



class PostActivityViewController: UIViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var SetLocation: UIButton!
    
    @IBOutlet weak var actName: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var numPeople: UITextField!
    @IBOutlet weak var actLocation: UITextField!
    @IBOutlet weak var actDescription: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnAddImage: UIButton!
    
    
    var imagePicker = UIImagePickerController()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actName.text = AddAct.name
        startTime.text = AddAct.Stime
        endTime.text = AddAct.Etime
        numPeople.text = AddAct.num
        actLocation.text = AddAct.locationname
        actDescription.text = AddAct.desc
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestring = formatter.string(from: time as Date)
        AddAct.creatTime = timestring

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        actLocation.text = AddAct.locationname
        self.view.endEditing(true)
    }

    //set the start time
    @IBAction func setST(_ sender: UITextField) {
        let datePicker = UIDatePicker()
        startTime.inputView = datePicker
        //using #selector(viewcontroller.function name) istand of "function name :"
        datePicker.addTarget(self, action: #selector(PostActivityViewController.datePickerST), for: .valueChanged)
    }
    
    func datePickerST(sender: UIDatePicker) {
        let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd HH:mm"
        startTime.text = formatter.string(from: sender.date)
    }
    //set the end time
    @IBAction func setET(_ sender: UITextField) {
        let datePicker = UIDatePicker()
        endTime.inputView = datePicker
        datePicker.addTarget(self, action: #selector(PostActivityViewController.datePickerET), for: .valueChanged)
    }
    func datePickerET(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        endTime.text = formatter.string(from: sender.date)
    }

    @IBAction func setNum(_ sender: UITextField) {
        //just can type num without .
        numPeople.keyboardType = UIKeyboardType.numberPad
    }
    
    @IBAction func OpenMap(_ sender: UIButton) {
        AddAct.name = actName.text!
        AddAct.Stime = startTime.text!
        AddAct.Etime = endTime.text!
        AddAct.num = numPeople.text!
        AddAct.desc = actDescription.text!
        self.performSegue(withIdentifier: "map", sender: self)
    }
    //add image
    @IBAction func btnAImage(_ sender: UIButton) {
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
            
            
            
        }
        
        
        //图片控制器退出
        picker.dismiss(animated: true, completion:nil)
    }
    
    //ADD NEW ONE
    @IBAction func SaveActivity(_ sender: AnyObject) {
        
        if ((actName.text != "")&&(startTime.text != "")&&(endTime.text != "")&&(numPeople.text != "")&&(actLocation.text != "") ){
            //latitude and longitude and location name added at map view controller
            AddAct.name = actName.text!
            AddAct.Stime = startTime.text!
            AddAct.Etime = endTime.text!
            AddAct.num = numPeople.text!
            AddAct.desc = actDescription.text!
            AddAct.creatorID = logUser.ID
            AddAct.creatorName = logUser.name
            var imageurlstring = ""
            
            //将图片存入storage
            let storageRef = FIRStorage.storage().reference().child(AddAct.creatorID + AddAct.creatTime)
            if let uploadData = UIImagePNGRepresentation(imageView.image!){
                storageRef.put(uploadData, metadata:nil, completion:{(metadata, error) in
                    
                    if error != nil {
                        print("this is error:",error)
                        return
                    }
                    print("this is metadata:",metadata)
                    
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        
                        //获取图片storage 地址
                        AddAct.image = profileImageUrl
                        print("this is the image url in the firebase", profileImageUrl)
                        AddAct.saveToDB(name: AddAct.name, Stime: AddAct.Stime, Etime: AddAct.Etime, locationname: AddAct.locationname, locationlatitude: AddAct.locationlatitude, locationlongitude: AddAct.locationlongitude, desc: AddAct.desc, num: AddAct.num, creatorID: AddAct.creatorID, creatorName: AddAct.creatorName, image: profileImageUrl)
                        
                        
                        AddAct.name = ""
                        AddAct.Stime = ""
                        AddAct.Etime = ""
                        AddAct.num = ""
                        AddAct.desc = ""
                        AddAct.creatorID = ""
                        AddAct.creatorName = ""
                        AddAct.image = ""
                    }
                    
                })
            }
           

        }else
        {
            //refer:http://www.hangge.com/blog/cache/detail_651.html
            let alertController = UIAlertController(title: "Warning",
                                                    message: "The name is empty, please entry!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //CANCEL
    @IBAction func CancelType(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Warning",
                                                message: "Are you sure to give up this edit？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Yes", style: .default,
                                     handler: {
                                        action in
                                        //========================
                                        self.actName.text = ""
                                        self.startTime.text = ""
                                        self.endTime.text = ""
                                        self.numPeople.text = ""
                                        self.actLocation.text = ""
                                        self.actDescription.text = ""
                                        
                                        AddAct.name = ""
                                        AddAct.Stime = ""
                                        AddAct.Etime = ""
                                        AddAct.num = ""
                                        AddAct.desc = ""
                                        AddAct.creatorID = ""
                                        AddAct.creatorName = ""
                                        AddAct.creatTime = ""
                                        AddAct.locationname = ""
                                        AddAct.locationlatitude = ""
                                        AddAct.locationlongitude = ""
                                        self.view.endEditing(true)
                                        self.performSegue(withIdentifier: "canceltotabbarcontroller", sender: self)
                                        
                                        //========================
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}
