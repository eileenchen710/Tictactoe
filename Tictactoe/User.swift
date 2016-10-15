//
//  User.swift
//  Tictactoe
//
//  Created by 王益民 on 10/15/16.
//  Copyright © 2016 W&C. All rights reserved.
//

import Foundation
import UIKit

var logUser : User = User()

class User : NSObject {
    var name = ""
    var email = ""
    var ID = ""
    var interest = ""
    var profileImage = ""
    
    //初始化用户信息
    func initUserInfo(name:String, email:String, ID: String, interest:String, profileImage:String){
        self.name = name
        self.email = email
        self.ID = ID
        self.interest = interest
        self.profileImage = profileImage
        
    }
    
    func getUserInfo() -> NSDictionary{
        return ["name": self.name, "email": self.email, "ID": self.ID, "interest": self.interest, "profileImage": self.profileImage]
    }
    
    //把图片从文件夹读出来
    //load image from path
    func loadimage() -> UIImage {
        
        var localImage = UIImage()
        
        if(self.ID != ""){
            
            
            let image = UIImage(contentsOfFile: fileInDocumentsDirectory(filename: self.ID+"***profileImage").path)
            
            if image == nil {
                
                print("missing image at: (path)")
            }
            else{
                localImage = image!
            }
            //print("\(path)")
            
        }
        return localImage
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
   
}

