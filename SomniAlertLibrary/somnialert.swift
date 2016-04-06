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
        Motion modes
    */
    enum motionMode {
        case HorizontalOnly
        case VerticalOnly
        case VerticalAndHorizontal
    }
    
    let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
        type: .TiltAlongVerticalAxis)
    let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
        type: .TiltAlongHorizontalAxis)
    
    // The values below determine the distance the alert moves when the user tilts their device
    var verticalMinValue = -30, verticalMaxValue = 30, horizontalMinValue = -30, horizontalMaxValue = 30

    
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

        // Configurations for icons
        closeButton = UIButton(frame: CGRect(x: self.frame.size.width - 30, y: 10, width: 10, height: 10))
        closeButton.setImage(UIImage(named: closeIconImageName), forState: .Normal)
        closeButton.addTarget(self, action: Selector("closeAlert"), forControlEvents: .TouchUpInside)
        self.addSubview(closeButton)
        
        // Configurations for the UILabels
        self.messageLabel.numberOfLines = 8
        self.addSubview(messageLabel)
        
        // Configurations for alertTypeImageView
        alertTypeImageView = UIImageView()
        alertTypeImageView.frame.size.width = 64
        alertTypeImageView.frame.size.height = 64
        alertTypeImageView.center = CGPointMake(self.mainView.bounds.width / 2 - 30, 40)
        self.addSubview(alertTypeImageView)
        
        
        
        // Auto-Layout configurations
        
        // Slanted View
        var viewsDict = Dictionary<String, UIView>()
        viewsDict["closeButton"] = self.closeButton
        viewsDict["messageLabel"] = self.messageLabel
        viewsDict["alertIcon"] = self.alertTypeImageView
        

        // Close Button Constraints
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        let closeButtonConstraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(10)-[closeButton]", options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: viewsDict)
        let closeButtonConstraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(10)-[closeButton]", options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: viewsDict)
        self.addConstraints(closeButtonConstraint_H)
        self.addConstraints(closeButtonConstraint_V)
        
        
        // Message Label Constraints
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let messageLabelContraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(5)-[messageLabel]-(5)-|", options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: viewsDict)
        let messageLabelConstraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(10)-[alertIcon]-(10)-[messageLabel]-(10)-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict)
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
     Displays the alert and allows you to add a closure to specify what to do when the alert is done.
     */
    func showAlert(typeOfAlert alertType: alertMode, messageToDisplay message: String, onComplete:()->Void){
        
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
        
        // On Completion Handler
        onComplete()
    }
    
    
    func applyMotion(typeOfMotion:motionMode){
        
        // Create group to apply each motion to the modal
        let group = UIMotionEffectGroup()
        
        
        // Identify the type of motions desired
        if typeOfMotion == .HorizontalOnly {
            group.motionEffects = [self.horizontalMotionEffect]
        }else if typeOfMotion == .VerticalOnly {
            group.motionEffects = [self.verticalMotionEffect]
        }else if typeOfMotion == .VerticalAndHorizontal {
            group.motionEffects = [self.verticalMotionEffect,self.horizontalMotionEffect]
        }
        
        // Apply the effects to the view
        self.addMotionEffect(group)

    }
    
    func createMotionEffect(typeOfMotion mode:motionMode){
        
        if mode == .HorizontalOnly {
            horizontalMotionEffect.minimumRelativeValue = horizontalMinValue
            horizontalMotionEffect.maximumRelativeValue = horizontalMaxValue
            applyMotion(.HorizontalOnly)
        }else if mode == .VerticalOnly {
            verticalMotionEffect.minimumRelativeValue = verticalMinValue
            verticalMotionEffect.maximumRelativeValue = verticalMaxValue
            applyMotion(.VerticalOnly)
        }else if mode == .VerticalAndHorizontal {
            horizontalMotionEffect.minimumRelativeValue = horizontalMinValue
            horizontalMotionEffect.maximumRelativeValue = horizontalMaxValue
            verticalMotionEffect.minimumRelativeValue = verticalMinValue
            verticalMotionEffect.maximumRelativeValue = verticalMaxValue
            applyMotion(.VerticalAndHorizontal)
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
