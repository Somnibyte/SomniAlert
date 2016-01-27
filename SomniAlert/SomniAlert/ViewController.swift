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

		// After you add the alert to your view, call the "setConstraints" function
		alert.setConstraints()
        
        // Apply a mothion effect (optional)
        alert.createMotionEffect(typeOfMotion: .VerticalAndHorizontal)
        

		// Display the alert
        alert.showAlert(typeOfAlert: .Notification, messageToDisplay: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc in dolor eget dolor cursus cursus a eu nisi. Proin vulputate, augue a hendrerit dignissim, lectus dolor ullamcorper mi, a commodo nisl neque eget ex. Curabitur porta id dolor ut tempus. Sed semper ")

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

