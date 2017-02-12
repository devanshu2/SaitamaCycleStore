//
//  UIDatePicker.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit

extension UIView{
    var screenshot: UIImage{
        self.setNeedsLayout()
        self.layoutIfNeeded()
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext();
        self.layer.render(in: context!)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return screenShot!
    }
}
