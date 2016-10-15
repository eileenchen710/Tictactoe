//
//  PostActivityViewController.swift
//  Tictactoe
//
//  Created by 王益民 on 10/11/16.
//  Copyright © 2016 W&C. All rights reserved.
//


import UIKit


class PostActivityViewController: UIViewController {
    
    @IBOutlet var SetLocation: UIButton!
    
    @IBOutlet weak var actName: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var numPeople: UITextField!
    @IBOutlet weak var actLocation: UITextField!
    @IBOutlet weak var actDescription: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actName.text = AddAct.name
        startTime.text = AddAct.Stime
        endTime.text = AddAct.Etime
        numPeople.text = AddAct.num
        actLocation.text = AddAct.locationname
        actDescription.text = AddAct.desc
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestring = formatter.string(from: time as Date)
        AddAct.createtime = timestring

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        actLocation.text = AddAct.locationname
        self.view.endEditing(true)
    }

    //set the start time
    @IBAction func setST(_ sender: UITextField) {
        let datePicker = UIDatePicker()
        startTime.inputView = datePicker
        //using #selector(viewcontroller.function name) istand of "function name :"
        datePicker.addTarget(self, action: #selector(PostActivityViewController.datePickerST), for: .valueChanged)
    }
    
    func datePickerST(sender: UIDatePicker) {
        let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd HH:mm"
        startTime.text = formatter.string(from: sender.date)
    }
    //set the end time
    @IBAction func setET(_ sender: UITextField) {
        let datePicker = UIDatePicker()
        endTime.inputView = datePicker
        datePicker.addTarget(self, action: #selector(PostActivityViewController.datePickerET), for: .valueChanged)
    }
    func datePickerET(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        endTime.text = formatter.string(from: sender.date)
    }

    @IBAction func setNum(_ sender: UITextField) {
        //just can type num without .
        numPeople.keyboardType = UIKeyboardType.numberPad
    }
    
    @IBAction func OpenMap(_ sender: UIButton) {
        AddAct.name = actName.text!
        AddAct.Stime = startTime.text!
        AddAct.Etime = endTime.text!
        AddAct.num = numPeople.text!
        AddAct.desc = actDescription.text!
        self.performSegue(withIdentifier: "map", sender: self)
    }
    
    //ADD NEW ONE
    @IBAction func SaveActivity(_ sender: AnyObject) {
        
        if ((actName.text != "")&&(startTime.text != "")&&(endTime.text != "")&&(numPeople.text != "")&&(actLocation.text != "") ){
            //latitude and longitude and location name added at map view controller
            AddAct.name = actName.text!
            AddAct.Stime = startTime.text!
            AddAct.Etime = endTime.text!
            AddAct.num = numPeople.text!
            AddAct.desc = actDescription.text!
            AddAct.creator = logUser.ID
            AddAct.saveToDB(name: AddAct.name, Stime: AddAct.Stime, Etime: AddAct.Etime, locationname: AddAct.locationname, locationlatitude: AddAct.locationlatitude, locationlongitude: AddAct.locationlongitude, desc: AddAct.desc, num: AddAct.num, creator: AddAct.creator)
            self.performSegue(withIdentifier: "savetotabbarcontroller", sender: self)
            
            AddAct.name = ""
            AddAct.Stime = ""
            AddAct.Etime = ""
            AddAct.num = ""
            AddAct.desc = ""
            AddAct.creator = ""

        }else
        {
            //refer:http://www.hangge.com/blog/cache/detail_651.html
            let alertController = UIAlertController(title: "Warning",
                                                    message: "The name is empty, please entry!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //CANCEL
    @IBAction func CancelType(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Warning",
                                                message: "Are you sure to give up this edit？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Yes", style: .default,
                                     handler: {
                                        action in
                                        //========================
                                        self.actName.text = ""
                                        self.startTime.text = ""
                                        self.endTime.text = ""
                                        self.numPeople.text = ""
                                        self.actLocation.text = ""
                                        self.actDescription.text = ""
                                        
                                        AddAct.name = ""
                                        AddAct.Stime = ""
                                        AddAct.Etime = ""
                                        AddAct.num = ""
                                        AddAct.desc = ""
                                        AddAct.creator = ""
                                        
                                        self.view.endEditing(true)
                                        self.performSegue(withIdentifier: "canceltotabbarcontroller", sender: self)
                                        
                                        //========================
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}
