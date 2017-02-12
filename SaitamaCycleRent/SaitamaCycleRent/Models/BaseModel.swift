//
//  BaseModel.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation

public class BaseModel: NSObject {
    public lazy var apiManager = NetworkManger()
    public var accessToken:String?
}
