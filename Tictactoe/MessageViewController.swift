//
//  MessageViewController.swift
//  Tictactoe
//
//  Created by 王益民 on 10/16/16.
//  Copyright © 2016 W&C. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController:  UIViewController {
    
    @IBOutlet weak var navigationbar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var image = UIImage()
        //image = logUser.loadimage()
        
        navigationbar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(btnBackP))
        navigationbar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(btnNewM))
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (FIRDataSnapshot) in
            if let dictionary = FIRDataSnapshot.value as? [String: AnyObject] {
                self.navigationbar.topItem?.title = dictionary["name"] as? String
            }
            
            }, withCancel: nil)
    }
    
    func btnBackP() {
        self.performSegue(withIdentifier: "ChatBackP", sender: self)
    }
    func btnNewM() {
         self.performSegue(withIdentifier: "newMessage", sender: self)
    }
}
