//
//  constants.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit

public struct Constants {
    
    static let kPost = "POST"
    static let kGet = "GET"
    static let kAuthorization = "Authorization"
    static let kEmail = "email"
    static let kPassword = "password"
    static let kAccessToken = "accessToken"
    
    struct Restrictions {
        static let email = 128
        static let password = 32
        static let ccNumber = 16
        static let ccCode = 3
    }
    
    struct Storyboards {
        static let Main = "Main"
    }
    
    struct Google {
        static let APIKey = "AIzaSyCM1nb-Omk5ItxF-51O42N8o-1pfomMPrg"
    }
    
    struct ViewControllerIdentifiers {
        static let AreaViewController = "areaViewController"
    }
    
    struct Segue {
        static let LoginToArea = "loginToArea"
        static let LoginToAreaNoAnimation = "loginToAreaNoAnimation"
        static let AreaToPay = "areaToPay"
    }
    
    struct API {
        static let Server: String = "http://localhost:8080/api/v1/"
        struct EndPoint {
            static let Authentication = "auth"
            static let Register = "register"
            static let Places = "places"
            static let Rent = "rent"
        }
    }
    
    struct FontNames {
        static let ProximaRegular = "ProximaNova-Regular"
        static let ProximaBold = "ProximaNova-Bold"
        static let ProximaSemiBold = "ProximaNova-Semibold"
    }
    
    struct CellIdentifier {
        static let GeneralHeaderCell = "hCell"
        static let GeneralTableCell = "cell"
        static let LoginSignupCombinedCell = "LoginSignupCombinedCell"
        static let InputCell = "InputCell"
    }
    
    struct General {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        static let Tmp = NSTemporaryDirectory()
        static let AnimationDuration = 0.3
    }
    
    struct ScreenNavigationTitle {
        static let HomeScreen = NSLocalizedString("Home", comment: "Home")
    }
    
    struct Notifications {
        static let FundDetailsBottomPageHeight = Notification.Name("FundDetailsBottomPageHeight")
    }
    
}
