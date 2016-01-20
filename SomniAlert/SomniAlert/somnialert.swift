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
        self.frame = CGRect(origin: self.mainView.center, size: CGSize(width: 200, height: 300))
        self.center = self.mainView.center
        self.backgroundColor = UIColor.whiteColor()
        
        
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
