//
//  ControlView.swift
//  weather-mohoo
//
//  Created by hy on 14-8-11.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//

import Foundation
import UIKit

class ControlView: NSObject {
    
    var defaultFrame = CGRectMake(0, 0, 100, 30)
    
    func createButtonWithTitle(title: String, selector: Selector, sender: AnyObject) -> UIButton {
        var button = UIButton(frame: defaultFrame)
        button.backgroundColor = UIColor.orangeColor()
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState:UIControlState.Highlighted)
        button.titleLabel.textColor = UIColor.whiteColor()
        button.titleLabel.font = UIFont.systemFontOfSize(16)
        
        button.addTarget(sender, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    
    func createLabelWithTitle(title: NSString, n:CGFloat) -> UILabel {

        
        var label = UILabel(frame: defaultFrame)
        label.text = title
        label.font = UIFont.systemFontOfSize(n)
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment =  NSTextAlignment.Center
        
        return label
    }
 
    
}
