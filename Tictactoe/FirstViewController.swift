
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
import CoreLocation
import MapKit


class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet var list : UITableView!
    
    var row = 0
    let id = logUser.ID
    
    var mylatitude = ""
    var mylongitude = ""
    var locationManager : CLLocationManager!
    var location: CLLocation! {
        didSet{
            mylatitude = "\(location.coordinate.latitude)"
            mylongitude = "\(location.coordinate.longitude)"
        }
    }
    
    //拉刷新控制器
    var refreshControl = UIRefreshControl()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        
        //添加刷新
        refreshControl.addTarget(self, action: #selector(FirstViewController.refreshData),
                                 for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        list.addSubview(refreshControl)
        refreshData()
        
        self.observeActivities()
        
        
        
        
    }
    
    // 刷新数据
    func refreshData() {
        
        let activity = Activity()
        activity.creatorName = "Eileen Chen"
        activity.num = "12"
        activity.Stime = "2016-10-17 16:10"
        activity.desc = "Let's go party"
        activity.name = ""
        
        self.list.reloadData()
        self.refreshControl.endRefreshing()

    }
    func observeActivities(){
        
        let ref = FIRDatabase.database().reference().child("activity")
        ref.observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                let activity = Activity()
                
                activity.setValuesForKeys(dictionary)
                activity.imageLocalPath = self.fileInDocumentsDirectory(filename: activity.image).absoluteString
                activities.append(activity)
                
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
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        list.reloadData()
    }

    
    //datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell = self.list.dequeueReusableCell(withIdentifier: "tableviewcell", for: indexPath) as! CustomCellTableViewCell
        let activity = activities[indexPath.row]
        cell.name.text = "by " + activity.creatorName
        cell.des.text = activity.desc
        cell.number.text = activity.num
        cell.time.text = activity.Stime.components(separatedBy: " ")[0]
        cell.title.text = activity.name
        cell.photo.image = loadimage(fileName: activity.creatTime)
        
        
        
        
        
        //
        //cell.photo.image = loadimage(path: fileInDocumentsDirectory(filename: TDM.tasks[indexPath.row].imagepath).path)
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


    //location
    func checkCoreLocationPermission(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }else if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus() == .restricted{
            print("authorized to use location service")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = (locations as! [CLLocation]).last
        print(self.mylatitude, self.mylongitude)
        //        var distancecal = distance(byLongitude: Double(longitude)!, latitude: Double(latitude)!, longitude: Double("120.12")!, latitude: Double("13.46")!)
        //        print("This is the distance", distancecal)
        locationManager.stopUpdatingLocation()
        //sequence()
    }
    //=============================
    //calculate distance
    //=============================
    func distance(byLongitude longitude1: Double, latitude latitude1: Double, longitude longitude2: Double, latitude latitude2: Double) -> Double {
        var curLocation = CLLocation(latitude: latitude1, longitude: longitude1)
        var otherLocation = CLLocation(latitude: latitude2, longitude: longitude2)
        var distance: Double = curLocation.distance(from: otherLocation)
        return distance
    }
    func sequence()-> Void{
        
        var mylo = "\(location.coordinate.longitude)"
        var myla = "\(location.coordinate.latitude)"
        var num = activities.count
        if (num >= 2)
        {
            for i in 0...num-1{
                
                var ilo = Double(activities[i].locationlongitude)
                var ila = Double(activities[i].locationlatitude)
                var d = distance(byLongitude: Double(mylo)!,latitude: Double(myla)!,longitude: ilo!,latitude: ila!)
                print("distance",d)
                var ds = String(d)
                activities[i].distance = ds
            }
            for i in 0...num-2 {
                for j in 0...(num - i - 2){
                    print("hahahhahahaadfaf",activities[j].name)
                    var jdistance = Double(activities[j].distance)
                    var j1distance = Double(activities[j+1].distance)
                    if (j1distance?.isLessThanOrEqualTo(jdistance!))! {
                        //交换位置
                        var activity = Activity()
                        
                        activity = activities[j]
                        activities[j] = activities[j+1]
                        activities[j+1] = activity
                        
                        
                    }
                }
            }
        }
        
    }

    @IBAction func brtnSort(_ sender: AnyObject) {
        sequence()
        list.reloadData()
        
    }

}

