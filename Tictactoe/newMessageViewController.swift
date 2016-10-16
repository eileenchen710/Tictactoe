//
//  newMessage.swift
//  Tictactoe
//
//  Created by 王益民 on 10/16/16.
//  Copyright © 2016 W&C. All rights reserved.
//

import UIKit
import Firebase

class newMessageViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nmnavigation: UINavigationBar!
    
    @IBOutlet weak var userTable: UITableView!
    let cellId = "cellID"
    
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        nmnavigation.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(btnCNM))
        
        fetchUser()
        userTable.reloadData()
    }
    
    func btnCNM() {
        self.performSegue(withIdentifier: "backMessage", sender: self)
    }
    
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (FIRDataSnapshot) in
            
            if let dictionary = FIRDataSnapshot.value as? [String: AnyObject] {
                let user = User()
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                DispatchQueue.main.async(execute: {self.userTable.reloadData()})
            }
            print(FIRDataSnapshot)
            }, withCancel: nil)
    }
    
    //datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        var cell = self.userTable.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as!allUserCellTableViewCell
        
        let user = users[indexPath.row]
        cell.name.text = user.name
        cell.email.text = user.email
        cell.interest.text = user.interest
        
        let url = URL(string: user.profileImage)
        let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: {(data, response, error) in
            //download hit an error so lets return out
            if error != nil{
                print(error)
                return
            }
            else{
                cell.UserImage.image = UIImage(data: data!)}
        })
        return cell
    }

   
}
