//
//  somnialert.swift
//  SomniAlert
//
//  Created by Guled on 1/19/16.
//  Copyright © 2016 Somnibyte. All rights reserved.
//

import Foundation
import UIKit

class SomniAlert: UIView {

	/**
	 The mainView is the view that the SomniAlert sits on top of. The mainView, in this example, is the view used in the ViewController.swift file.
	 */
	var mainView: UIView
	/**
	 The slanted view is the view that is slanted and is clipped onto the alert's view
	 */
	var slantedView: UIView = UIView()
	/**
	 This variable allows you to choose the image name for the close button
	 */
	var closeIconImageName: String = "close"

	var closeButton: UIButton!
	let blurEffect = UIBlurEffect(style: .Dark)
	let visualEffect = UIVisualEffectView()

	/**
	 Default Initializer
	 */
	init(frame: CGRect, viewToSitOnTopOf mainView: UIView) {

		self.mainView = mainView
		super.init(frame: frame)

		// Configurations for the main SomniAlert view
		self.frame = CGRect(x: self.mainView.center.x, y: self.mainView.center.y - 10, width: 200, height: 300)
		self.center = self.mainView.center // Place the view in the center of the users view
		self.backgroundColor = UIColor.whiteColor() // Default background: white
		self.clipsToBounds = true

		// Configurations for the slanted view
		slantedView = UIView(frame: CGRect(x: -50, y: 0, width: self.frame.size.width * 2, height: 200))
		slantedView.backgroundColor = UIColor(red: 0.204, green: 0.231, blue: 0.259, alpha: 1.00)
		slantedView.transform = CGAffineTransformMakeRotation(50.0)
		self.addSubview(slantedView)

		// Configurations for icons
		closeButton = UIButton(frame: CGRect(x: self.frame.size.width - 30, y: 10, width: 25, height: 25))
		closeButton.setImage(UIImage(named: closeIconImageName), forState: .Normal)
		closeButton.addTarget(self, action: Selector("closeAlert"), forControlEvents: .TouchUpInside)
		self.addSubview(closeButton)

		// Auto-Layout configurations

		// Slanted View
		self.slantedView.translatesAutoresizingMaskIntoConstraints = false
		var viewsDict = Dictionary<String, UIView>()
		viewsDict["slantedView"] = self.slantedView
        viewsDict["closeButton"] = self.closeButton

		let slantedViewConstraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(-50)-[slantedView]-(-50)-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: viewsDict)
		let slantedViewConstraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(-40)-[slantedView]-320-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict)
		self.addConstraints(slantedViewConstraint_H)
		self.addConstraints(slantedViewConstraint_V)

		// Close Button
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        let closeButtonConstraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(10)-[closeButton]", options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: viewsDict)
         let closeButtonConstraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(10)-[closeButton]", options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: viewsDict)
        self.addConstraints(closeButtonConstraint_H)
        self.addConstraints(closeButtonConstraint_V)
        

		// Hide the alert until activated
		self.alpha = 0.0
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 Adjusts the alert to an appropriate size of the users device
	 */
	func setConstraints() {
		// Set up the views to be shifted
		self.translatesAutoresizingMaskIntoConstraints = false
		var viewsDict = Dictionary<String, UIView>()
		viewsDict["alertView"] = self

		// Incorporate the auto layout mechanisms onto the mainView
		let alertViewConstraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[alertView]-50-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict)
		let alertViewConstraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-120-[alertView]-120-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict)
		self.mainView.addConstraints(alertViewConstraint_H)
		self.mainView.addConstraints(alertViewConstraint_V)
	}

	/**
	 Displays the alert
	 */
	func showAlert() {

		self.visualEffect.effect = blurEffect
		self.visualEffect.frame = self.mainView.frame

		// Animate somnialert
		UIView.animateWithDuration(1.0) { () -> Void in
			self.mainView.insertSubview(self.visualEffect, belowSubview: self)
			self.frame.origin.y += 10
			self.alpha = 1.0
		}
	}

	/**
	 Closes the alert
	 */
	func closeAlert() {
		self.removeFromSuperview()
		self.visualEffect.removeFromSuperview()
	}
}
