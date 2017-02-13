//
//  BaseModel.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation

open class BaseModel: NSObject {
    open lazy var apiManager = NetworkManger()
    open var accessToken:String?
    
    open func cancelActiveAPICallTask() {
        self.apiManager.cancelActiveTask()
    }
}
