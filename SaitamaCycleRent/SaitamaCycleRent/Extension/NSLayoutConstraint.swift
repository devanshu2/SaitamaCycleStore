//
//  NSLayoutConstaint.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    static func addWidthConstraint(view theView:UIView, withWidth width:CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint.addWidthConstraint(view: theView, withWidth: width, andRelation: .equal)
    }
    
    static func addWidthConstraint(view theView:UIView, withWidth width:CGFloat, andRelation relation:NSLayoutRelation) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: theView,
                                  attribute: .width,
                                  relatedBy: relation,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 1.0,
                                  constant: width)
    }
    
    static func addHeightConstraint(view theView:UIView, withHeight height:CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint.addHeightConstraint(view: theView, withHeight: height, andRelation: .equal)
    }
    
    static func addHeightConstraint(view theView:UIView, withHeight height:CGFloat, andRelation relation:NSLayoutRelation) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: theView,
                                  attribute: .height,
                                  relatedBy: relation,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 1.0,
                                  constant: height)
    }
    
    static func addTrailingConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let trailing = NSLayoutConstraint(item: view,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: supView,
                                          attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: separation)
        return trailing
    }
    
    static func addLeadingConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let trailing = NSLayoutConstraint(item: view,
                                          attribute: .leading,
                                          relatedBy: .equal,
                                          toItem: supView,
                                          attribute: .leading,
                                          multiplier: 1.0,
                                          constant: separation)
        return trailing
    }
    
    static func addHorizontalSpacingConstraint(withFirstView fView:UIView, secondView sView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: sView,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: fView,
                                      attribute: .right,
                                      multiplier: 1.0,
                                      constant: separation)
        return cons
    }
    
    static func addTopConstraint(withView view:UIView, superView supView:Any, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let top = NSLayoutConstraint(item: view,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: supView,
                                     attribute: .bottom,
                                     multiplier: 1.0,
                                     constant: separation)
        return top
    }
    
    static func addBottomConstraint(withView view:UIView, superView supView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let bottom = NSLayoutConstraint(item: view,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: supView,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: separation)
        return bottom
    }
    
    static func addVerticalSpacingConstraint(withFirstView fView:UIView, secondView sView:UIView, andSeparation separation:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: sView,
                                      attribute: .top,
                                      relatedBy: .equal,
                                      toItem: fView,
                                      attribute: .bottom,
                                      multiplier: 1.0,
                                      constant: separation)
        return cons
    }
    
    static func addCentreXConstraint(withView view:UIView, superView supView:UIView, andConstant constantK:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: view,
                                      attribute: .centerX,
                                      relatedBy: .equal,
                                      toItem: supView,
                                      attribute: .centerX,
                                      multiplier: 1.0,
                                      constant: constantK)
        return cons
    }
    
    static func addCentreXConstraint(withView view:UIView, superView supView:UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint.addCentreXConstraint(withView: view, superView: supView, andConstant: 0.0)
    }
    
    static func addCentreYConstraint(withView view:UIView, superView supView:UIView, andConstant constantK:CGFloat) -> NSLayoutConstraint {
        let cons = NSLayoutConstraint(item: view,
                                      attribute: .centerY,
                                      relatedBy: .equal,
                                      toItem: supView,
                                      attribute: .centerY,
                                      multiplier: 1.0,
                                      constant: constantK)
        return cons
    }
    
    static func addCentreYConstraint(withView view:UIView, superView supView:UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint.addCentreXConstraint(withView: view, superView: supView, andConstant: 0.0)
    }
}
