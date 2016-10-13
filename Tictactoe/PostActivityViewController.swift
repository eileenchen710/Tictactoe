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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func OpenMap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "map", sender: self)
    }
    
}
