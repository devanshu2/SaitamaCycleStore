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
    public var expiration:String?
    public var code:String?
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YY"
        let eData = dateFormatter.date(from: self.expiration!)
        guard eData != nil else {
            throw RentPaymentCallError.invalidExpiry
        }
        guard eData! < Date() else {
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
