//
//  FBLoginViewController.swift
//  Tictactoe
//
//  Created by 王益民 on 10/10/16.
//  Copyright © 2016 W&C. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Firebase
import FBSDKCoreKit
class FBLoginViewController: UIViewController, UITableViewDelegate, FBSDKLoginButtonDelegate{
    
    var loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.loginButton.center = self.view.center
        self.loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton, didCompleteWith result: FBSDKLoginManagerLoginResult, error: Error?) {
        
        print("user logged In")
        
        self.loginButton.isHidden = true
        self.performSegue(withIdentifier: "FBmainapp", sender: self)
        
        if (error != nil) {
            self.loginButton.isHidden = false
        }
        else{
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                
                print("user logged in to Firebase App")
            }
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("user logged out...")
    }
    
    //    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool{
    //        return true
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

