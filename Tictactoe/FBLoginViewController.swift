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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = self.view.center
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton, didCompleteWith result: FBSDKLoginManagerLoginResult, error: Error?) {
        if error != nil{
            print(error?.localizedDescription)
        }
        else if(result.isCancelled){
            print("Cancelled")
        }
        else{
            print("log in complete")
            }
            //跳转页面
        
        self.performSegue(withIdentifier: "mainapp", sender: self)
            if((FBSDKAccessToken.current()) != nil){
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        print("This is the result:",result)
                        let fbDetails = result as! NSDictionary
                        //FBUser.ID = fbDetails.value(forKey: "id") as! String
                        //print("This is the facebook id:", FBUser.ID)
                    }
                })
            }
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            print("user logged in facebook")
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

