//
//  Payment.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 13/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation

class Payment: BaseModel {
    public var number:String?
    public var name:String?
    public var expiration:String? {
        get {
            if self.expirationMonth == nil || self.expirationYear == nil {
                return nil
            }
            else {
                if self.expirationMonth!.isNumeric() && self.expirationYear!.isNumeric() {
                    let eM = Int(self.expirationMonth!)!
                    let eY = Int(self.expirationYear!)!
                    let date = Date()
                    let calendar = Calendar.current
                    
                    let sYear = String(calendar.component(.year, from: date))
                    let year = Int(sYear.substring(from:sYear.index(sYear.endIndex, offsetBy: -2)))!
                    let month = calendar.component(.month, from: date)
                    var allCool = false
                    if eM > 12 || eM < 1 {
                        allCool = false
                    }
                    else if year > eY {
                        allCool = false
                    }
                    else if year < eY {
                        allCool = true
                    }
                    else if year == eY && month < eM {
                        allCool = true
                    }
                    else {
                        allCool = false
                    }
                    if allCool {
                        return String(eM) + "/" + String(eY)
                    }
                    else {
                        return nil
                    }
                }
                else {
                    return nil
                }
            }
        }
    }
    public var code:String?
    public var expirationMonth:String?
    public var expirationYear:String?
    private let kAPIURL = URL(string: Constants.API.Server + Constants.API.EndPoint.Rent)

    private let kNumber = "number"
    private let kName = "name"
    private let KExpiration = "expiration"
    private let kCode = "code"
    
    public func rent(withCompletionHandler completionHandler: @escaping (Bool, Error?, String?) -> Swift.Void) throws {
        guard ((self.number != nil) && ((self.number?.length)! == Constants.Restrictions.ccNumber)) else {
            throw RentPaymentCallError.invalidNumber
        }
        guard self.number!.isNumeric() else {
            throw RentPaymentCallError.invalidNumber
        }
        guard ((self.name != nil) && ((self.name?.length)! > 0)) else {
            throw RentPaymentCallError.blankName
        }
        
        guard self.expiration != nil else {
            throw RentPaymentCallError.invalidExpiry
        }
        guard ((self.code != nil) && ((self.code?.length)! == Constants.Restrictions.ccCode)) else {
            throw RentPaymentCallError.invalidCode
        }
        guard self.code!.isNumeric() else {
            throw RentPaymentCallError.invalidCode
        }
        
        let postData = [self.kNumber:self.number!, self.kName:self.name!, self.KExpiration:self.expiration!, self.kCode:self.kCode]
        self.apiManager.postData(withParameters: postData, apiEndpoint: self.kAPIURL!) { (data, response, error) in
            var statusCode = 200
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            if let errorCode = NodeResponseStatusErrorCode(rawValue: statusCode) {
                let errorMessage = errorCode.localMessage(errorCode)
                completionHandler(false, error, errorMessage)
                return
            }
            else {
                do {
                    if (try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any>) != nil {
                        completionHandler(true, nil, nil)
                    }
                }
                catch {
                    
                }
            }
            completionHandler(false, error, nil)
        }
    }
}
