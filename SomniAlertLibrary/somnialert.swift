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

	/**
	 Alert modes
	 */
	enum alertMode {
		case Success
		case Failure
		case Trash
		case Notification
	}

	/**
	 The message label is the message that is displayed on the alert itself.
	 */
	var messageLabel: UILabel = UILabel()

	var closeButton: UIButton!

	/**
	 Image that is on the top of the alert and next to the close button
	 */
	var alertTypeImageView: UIImageView!

	let blurEffect = UIBlurEffect(style: .Dark)
	let visualEffect = UIVisualEffectView()

	/**
	 Default Initializer
	 */
	init(frame: CGRect, viewToSitOnTopOf mainView: UIView) {

		self.mainView = mainView
		super.init(frame: frame)

		// Configurations for the main SomniAlert view
		self.center = self.mainView.center // Place the view in the center of the users view
		self.backgroundColor = UIColor.whiteColor() // Default background: white
		self.clipsToBounds = true

		// Configurations for the slanted view
		slantedView = UIView(frame: CGRect(x: -50, y: 0, width: self.frame.size.width * 2, height: 200))
		slantedView.backgroundColor = UIColor(red: 0.204, green: 0.231, blue: 0.259, alpha: 1.00)
        let degreesToRadians = { (x:Double) in
           CGFloat(M_PI * (x) / 180.0)
        }
		slantedView.transform = CGAffineTransformMakeRotation(degreesToRadians(170))
		slantedView.layer.shouldRasterize = true
		self.addSubview(slantedView)

		// Configurations for icons
		closeButton = UIButton(frame: CGRect(x: self.frame.size.width - 30, y: 10, width: 10, height: 10))
		closeButton.setImage(UIImage(named: closeIconImageName), forState: .Normal)
		closeButton.addTarget(self, action: Selector("closeAlert"), forControlEvents: .TouchUpInside)
		self.addSubview(closeButton)

		// Configurations for the UILabels
		self.messageLabel.numberOfLines = 8
		self.addSubview(messageLabel)

		// Auto-Layout configurations

		// Slanted View
		self.slantedView.translatesAutoresizingMaskIntoConstraints = false
		var viewsDict = Dictionary<String, UIView>()
		viewsDict["slantedView"] = self.slantedView
		viewsDict["closeButton"] = self.closeButton
		viewsDict["messageLabel"] = self.messageLabel

		let slantedViewConstraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(-50)-[slantedView]-(-50)-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: viewsDict)
		let slantedViewConstraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(-40)-[slantedView]-(50)-[messageLabel]-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict)
		self.addConstraints(slantedViewConstraint_H)
		self.addConstraints(slantedViewConstraint_V)

		// Close Button
		self.closeButton.translatesAutoresizingMaskIntoConstraints = false
		let closeButtonConstraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(10)-[closeButton]", options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: viewsDict)
		let closeButtonConstraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(10)-[closeButton]", options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: viewsDict)
		self.addConstraints(closeButtonConstraint_H)
		self.addConstraints(closeButtonConstraint_V)

		// Configurations for alertTypeImageView
		alertTypeImageView = UIImageView()
		alertTypeImageView.frame.size.width = 64
		alertTypeImageView.frame.size.height = 64
		alertTypeImageView.center = CGPointMake(self.mainView.bounds.width / 2 - 30, 40)
		self.addSubview(alertTypeImageView)

		// Message label
		self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
		let messageLabelContraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(10)-[messageLabel]-(10)-|", options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: viewsDict)
		let messageLabelConstraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[messageLabel]-(10)-|", options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: viewsDict)
		self.addConstraints(messageLabelContraint_H)
		self.addConstraints(messageLabelConstraint_V)

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
		let alertViewConstraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(30)-[alertView]-(30)-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict)
		let alertViewConstraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(100)-[alertView]-(100)-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict)
		self.mainView.addConstraints(alertViewConstraint_H)
		self.mainView.addConstraints(alertViewConstraint_V)
	}

	/**
	 Displays the alert
	 */
	func showAlert(typeOfAlert alertType: alertMode, messageToDisplay message: String) {

		// Setup the alert image and message
		switch (alertType) {
		case .Success:
			self.alertTypeImageView.image = UIImage(named: "success")
		case .Failure:
			self.alertTypeImageView.image = UIImage(named: "failed")
		case .Notification:
			self.alertTypeImageView.image = UIImage(named: "notification")
		case .Trash:
			self.alertTypeImageView.image = UIImage(named: "trash")
		}

		self.messageLabel.text = message

		// Prepare the alert
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
