//
//  User.swift
//  Tictactoe
//
//  Created by 王益民 on 10/15/16.
//  Copyright © 2016 W&C. All rights reserved.
//

import Foundation

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
}

