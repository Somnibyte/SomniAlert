//
//  somnialert.swift
//  SomniAlert
//
//  Created by Guled on 1/19/16.
//  Copyright © 2016 Somnibyte. All rights reserved.
//

import Foundation
import UIKit

class SomniAlert:UIView {
    
    /** 
     The mainView is the view that the SomniAlert sits on top of. The mainView, in this example, is the view used in the ViewController.swift file.
    */
    var mainView:UIView
    
    /**
     Default Initializer
    */
    init(frame:CGRect, viewToSitOnTopOf mainView:UIView){
        
        self.mainView = mainView
        super.init(frame: frame)
        
        
        // Configurations for the main SomniAlert view
        self.frame = CGRect(origin: self.mainView.center, size: CGSize(width: 200, height: 300))
        self.center = self.mainView.center // Place the view in the center of the users view
        self.backgroundColor = UIColor.whiteColor() // Default background: white
        self.clipsToBounds = true
        
        // Configurations for the slanted view
        let slantedView = UIView(frame: CGRect(x: -10, y: -10, width: self.frame.size.width * 2, height: self.frame.size.height/2))
        slantedView.backgroundColor = UIColor(red:0.204, green:0.231, blue:0.259, alpha:1.00)
        slantedView.transform = CGAffineTransformMakeRotation(-50.0)
        self.addSubview(slantedView)
        
        // Hide the alert until activated
        self.alpha = 0.0
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    /**
     Displays the alert
     */
    func showAlert(){
        
        // Setup blur effect
        let blurEffect = UIBlurEffect(style: .Dark)
        let visualEffect = UIVisualEffectView()
        
        visualEffect.effect = blurEffect
        visualEffect.frame = self.mainView.frame

        // Animate somnialert
        UIView.animateWithDuration(1.0) { () -> Void in
            self.mainView.insertSubview(visualEffect, belowSubview: self)
            self.alpha = 1.0
        }
    }

}
