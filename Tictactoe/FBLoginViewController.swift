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
        
//        print("user logged In")
        
//        self.loginButton.isHidden = true
        
//        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//            print("user logged in facebook")
//        }
//
//        //get the personal profile
//        if((FBSDKAccessToken.current()) != nil){
//            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
//                
//                print("This is the result:",result)
//                let fbDetails = result as! NSDictionary
//                logUser.name = fbDetails.value(forKey: "name") as! String
//                logUser.email = fbDetails.value(forKey: "email") as! String
//                logUser.ID = fbDetails.value(forKey: "id") as! String
//                print("This is the facebook name:", logUser.name)
//                print("This is the facebook email:", logUser.email)
//                print("This is the facebook ID:", logUser.ID)
//            })
//        }
        if error != nil{
            print(error?.localizedDescription)
        }
        else if(result.isCancelled){
            print("Cancelled")
        }
        else{
            print("log in complete")
            self.loginButton.isHidden = true
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                print("user logged in facebook")
            }
            if((FBSDKAccessToken.current()) != nil){
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        print("This is the result:",result)
                        let fbDetails = result as! NSDictionary
                        let tryemail = fbDetails.value(forKey: "email") as! String
                        let tryname = fbDetails.value(forKey: "name") as! String
                        let tryid = fbDetails.value(forKey: "id") as! String
                        print("This is the facebook email:", tryemail)
                        print("This is the facebook name:", tryname)
                        print("This is the facebook id:", tryid)
                        logUser.email = tryemail
                        logUser.name = tryname
                        logUser.ID = tryid
                        //====================================
                        //save fbuser to firebase
                        let ref = FIRDatabase.database().reference(fromURL: "https://tictactoe-d248f.firebaseio.com/")
                        
                        let usersReference = ref.child("users").child(tryid)
                        let values = ["name": logUser.name, "email": logUser.email]
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            if err != nil{
                                print(err)
                                return
                            }
                            
                            print("Save user successfully into Firebase db")
                        })
                        //====================================

                    }
                })
            }
            
        }

        if (error != nil) {
            self.loginButton.isHidden = false
        }
        else{
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                
                print("user logged in to Firebase App")
            }
        }
        self.performSegue(withIdentifier: "FBmainapp", sender: self)
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

