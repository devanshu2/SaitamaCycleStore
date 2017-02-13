//
//  User.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation

open class User: BaseModel {
    open var email:String?
    open var password:String?
    
    private let kAuthenticationURL = URL(string: Constants.API.Server + Constants.API.EndPoint.Authentication)
    
    private let kRegisterURL = URL(string: Constants.API.Server + Constants.API.EndPoint.Register)
    
    open func clearCredentials() {
        self.email = nil
        self.password = nil
    }
    
    open func authentication(withCompletionHandler completionHandler: @escaping (String?, Error?, String?) -> Swift.Void) throws {
        
        guard ((self.email != nil) && ((self.email?.length)! > 0)) else {
            throw UserAuthenticationCallError.blankEmail
        }
        guard self.email!.length <= Constants.Restrictions.email else {
            throw UserAuthenticationCallError.largeEmail
        }
        guard String.isValidateEmail(self.email!) else {
            throw UserAuthenticationCallError.invalidEmail
        }
        guard ((self.password != nil) && ((self.password?.length)! > 0)) else {
            throw UserAuthenticationCallError.blankPassword
        }
        guard self.password!.length <= Constants.Restrictions.password else {
            throw UserAuthenticationCallError.largePassword
        }
        
        let postData = [Constants.kEmail:self.email!, Constants.kPassword:self.password!]
        self.apiManager.postData(withParameters: postData, apiEndpoint: self.kAuthenticationURL!) { (data, response, error) in
            
            var statusCode = 200
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            if let errorCode = NodeResponseStatusErrorCode(rawValue: statusCode) {
                let errorMessage = errorCode.localMessage(errorCode)
                completionHandler(nil, error, errorMessage)
                return
            }
            else {
                do {
                    if let apiResponseData = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                        if apiResponseData[Constants.kAccessToken] != nil {
                            self.accessToken = apiResponseData[Constants.kAccessToken] as! String?
                            completionHandler(self.accessToken, nil, nil)
                            return
                        }
                    }
                }
                catch {
                    
                }
            }
            completionHandler(nil, error, nil)
        }
    }
    
    open func register(withCompletionHandler completionHandler: @escaping (String?, Error?, String?) -> Swift.Void) throws {
        
        guard ((self.email != nil) && ((self.email?.length)! > 0)) else {
            throw UserRegisterCallError.blankEmail
        }
        guard self.email!.length <= Constants.Restrictions.email else {
            throw UserRegisterCallError.largeEmail
        }
        guard String.isValidateEmail(self.email!) else {
            throw UserRegisterCallError.invalidEmail
        }
        guard ((self.password != nil) && ((self.password?.length)! > 0)) else {
            throw UserRegisterCallError.blankPassword
        }
        guard self.password!.length <= Constants.Restrictions.password else {
            throw UserRegisterCallError.largePassword
        }
        
        let postData = [Constants.kEmail:self.email!, Constants.kPassword:self.password!]
        self.apiManager.postData(withParameters: postData, apiEndpoint: self.kRegisterURL!) { (data, response, error) in
            var statusCode = 200
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            if let errorCode = NodeResponseStatusErrorCode(rawValue: statusCode) {
                let errorMessage = errorCode.localMessage(errorCode)
                completionHandler(nil, error, errorMessage)
                return
            }
            else {
                do {
                    if let apiResponseData = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                        if apiResponseData[Constants.kAccessToken] != nil {
                            self.accessToken = apiResponseData[Constants.kAccessToken] as! String?
                            completionHandler(self.accessToken, nil, nil)
                            return
                        }
                    }
                }
                catch {
                    
                }
            }
            completionHandler(nil, error, nil)
        }
    }
}
