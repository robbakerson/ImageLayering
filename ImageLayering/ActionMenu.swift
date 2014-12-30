//
//  ActionMenu.swift
//  ImageLayering
//
//  Created by Robb.Akerson on 12/19/14.
//  Copyright (c) 2014 com.target.internal. All rights reserved.
//

import Foundation
import UIKit

class ActionMenu: UIViewController {
    
    @IBOutlet weak var pickImageBtn: UIBarButtonItem!
    var rootController:ViewController = ViewController()
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pickImage(sender: AnyObject) {
        //window.rootController.openPicker()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
