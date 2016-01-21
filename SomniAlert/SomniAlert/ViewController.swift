//
//  ViewController.swift
//  SomniAlert
//
//  Created by Guled on 1/19/16.
//  Copyright © 2016 Somnibyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize the SomniAlert
        var alert = SomniAlert(frame: CGRect(), viewToSitOnTopOf: self.view)
    
        
        // Add the alert to your view
        self.view.addSubview(alert)
        
        
        //Display the alert
        alert.showAlert()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

