
//
//  FirstViewController.swift
//  Tictactoe
//
//  Created by chen ya lin on 7/09/2016.
//  Copyright © 2016 W&C. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var list : UITableView!
    
    let id = logUser.ID
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.observeActivities()
        
        
        
        
    }
    
     func observeActivities(){
        
        let ref = FIRDatabase.database().reference().child("activity")
        ref.observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                let activity = Activity()
                
                activity.setValuesForKeys(dictionary)
                activity.imageLocalPath = self.fileInDocumentsDirectory(filename: activity.image).absoluteString
                homeActivities.append(activity)
                
                DispatchQueue.main.async(execute: {
                    self.list.reloadData()
                })
                
                print(activity.name)
                
            }
            
            }, withCancel: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.observeActivities()
        list.reloadData()
    }
    
    
    //datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return homeActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell = self.list.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeViewCell
        let activity = homeActivities[indexPath.row]
        cell.creator.text = activity.creatorName
        cell.photo.image = loadimage(fileName: activity.creatTime)
        cell.icon.image = loadimage(fileName: activity.creatorName)
        
        
        
    
        return cell
    }
    
    
    
    func documentsDirectory() -> URL {
        let documentsFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsFolderPath
    }
    // Get path for a file in the directory
    
    func fileInDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
    
    //把图片从文件夹读出来
    //load image from path
    func loadimage(fileName: String) -> UIImage {
        
        var localImage = UIImage()
        
        //  if(self.ID != ""){
        
        
        let image = UIImage(contentsOfFile: fileInDocumentsDirectory(filename: fileName).path)
        
        if image == nil {
            
            print("missing image at: (path)")
        }
        else{
            localImage = image!
        }
        //print("\(path)")
        
        //    }
        return localImage
    }
    
    
  
    
}

