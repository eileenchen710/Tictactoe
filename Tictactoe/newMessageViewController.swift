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
    
    //@IBOutlet weak var nmnavigation: UINavigationBar!
    
    @IBOutlet weak var userTable: UITableView!
    //var nmnavigation: UINavigationBar
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //nmnavigation.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(btnCNM))
        
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
                user.name = dictionary["name"] as! String
                user.email = dictionary["email"] as! String
                user.interest = dictionary["interest"] as! String
                user.profileImage = dictionary["profileImage"] as! String
                self.users.append(user)
                DispatchQueue.main.async(execute: {self.userTable.reloadData()})
            }
            print("firdatasnapshot:",FIRDataSnapshot)
            }, withCancel: nil)
    }
    //跳转
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "chat", sender: self)
    }
    
    //datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("user count:",users.count)
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        var cell = self.userTable.dequeueReusableCell(withIdentifier: "usercell", for: indexPath) as! allUserCellTableViewCell

        let user = users[indexPath.row]
        cell.name.text = user.name
        //cell.email.text = user.email
        //
        print("user image string:", user.profileImage)
        let url = URL(string: user.profileImage)
        print("user image url:", url)
        

        let task = URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            //download hit an error so lets return out
            if error != nil{
                print(error)
                return
            }
            else{
                cell.userimage.image = UIImage(data: data!)
            }
        })
        //print("image description:", cell.userimage.image?.description)
        return cell
    }

   
}
