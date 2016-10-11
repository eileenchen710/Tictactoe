//
//  personalpage.swift
//  Tictactoe
//
//  Created by 王益民 on 10/11/16.
//  Copyright © 2016 W&C. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FBSDKCoreKit

class PersonalPage: UIViewController {
    
    var name = ""
    
    @IBAction func didTapLogout(_ sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        
        FBSDKAccessToken.setCurrent(nil)
        
        
        
        let mianStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController: UIViewController = mianStoryboard.instantiateViewController(withIdentifier: "Login View Controller")
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
