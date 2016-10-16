//
//  addactivity.swift
//  Tictactoe
//
//  Created by 王益民 on 10/13/16.
//  Copyright © 2016 W&C. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import FBSDKLoginKit
import Firebase
import FBSDKCoreKit

var AddAct : addactivity = addactivity()

class addactivity: NSObject, CLLocationManagerDelegate {
    
//    var location: CLLocation! {
//        didSet{
//            mylatitude = "\(location.coordinate.latitude)"
//            mylongitude = "\(location.coordinate.longitude)"
//            
//        }
    var name = ""
    var Stime = ""
    var Etime = ""
    var locationname = ""
    var locationlatitude = ""
    var locationlongitude = ""
    var desc = ""
    var num = ""
    var image = ""
    var creatorName = ""
    var creatorID = ""   //save id
    var creatTime = ""
    
    func saveToDB(name: String, Stime: String, Etime: String, locationname: String, locationlatitude: String, locationlongitude: String, desc: String, num: String, creatorID: String, creatorName: String, image: String) ->Void {
        
        let activityid = creatorID + creatTime
        
        let ref = FIRDatabase.database().reference(fromURL: "https://tictactoe-d248f.firebaseio.com/")
        //use user id and time as the id of activity
        let usersReference = ref.child("activity").child(activityid)
        let values = ["name": name, "Stime": Stime, "Etime": Etime, "locationname": locationname, "locationlatitude": locationlatitude, "locationlongitude": locationlongitude, "desc": desc,"num": num, "creatorID": creatorID, "creatorName": creatorName, "creatTime": creatTime, "image": image]
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil{
                print(err)
                return
            }
            
            print("Save activity successfully into Firebase db")
        })

        
    }
}

