//
//  PublicEnums.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation

enum UserAuthenticationCallError: Error {
    case blankEmail
    case largeEmail
    case invalidEmail
    case blankPassword
    case largePassword
}

enum UserRegisterCallError: Error {
    case blankEmail
    case largeEmail
    case invalidEmail
    case blankPassword
    case largePassword
}

enum LoginPageState {
    case welcome
    case login
    case register
}

enum NodeResponseErrorCode: String {
    case invalidJson  = "0001A"
    case invalidCred  = "0001B"
    case invalidToken = "0001C"
    
    func localMessage(_ code:NodeResponseErrorCode) -> String? {
        switch code {
        case .invalidJson:
            return NSLocalizedString("Invalid api json format.", comment: "Saitama")
        case .invalidCred:
            return NSLocalizedString("Invalid credentials.", comment: "Saitama")
        case .invalidToken:
            return NSLocalizedString("Invalid access token.", comment: "Saitama")
        default:
            return nil
        }
    }
}

enum NodeResponseStatusErrorCode: Int {
    case badRequest   = 400
    case unauthorized = 401
    case forbidden    = 403
    
    func localMessage(_ code:NodeResponseStatusErrorCode) -> String? {
        switch code {
        case .badRequest:
            return NSLocalizedString("Bad Request.", comment: "Saitama")
        case .unauthorized:
            return NSLocalizedString("Invalid credentials.", comment: "Saitama")
        case .forbidden:
            return NSLocalizedString("Invalid access token.", comment: "Saitama")
        default:
            return nil
        }
    }
}
