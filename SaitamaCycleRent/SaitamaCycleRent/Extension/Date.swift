//
//  Date.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: self as Date)
        return dateString
    }
}
