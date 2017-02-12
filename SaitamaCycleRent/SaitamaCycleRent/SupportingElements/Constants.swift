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
    }
    
    struct Storyboards {
        static let Main = "Main"
    }
    
    struct Google {
        static let APIKey = "AIzaSyCM1nb-Omk5ItxF-51O42N8o-1pfomMPrg"
    }
    
    struct ViewControllerIdentifiers {
        
    }
    
    struct Segue {
        
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
    
    struct Colors {
        static let Teal = UIColor(hex: "009788")
        static let Blue = UIColor(hex: "4083f1")
        static let Yellow = UIColor(hex: "f6c84c")
        static let Green = UIColor(hex: "4caf50")
        static let Red = UIColor(hex: "e74848")
        static let BlueBright = UIColor(hex: "658fff")
        static let DarkGrey = UIColor(hex: "454545") // 69 69 69
        static let Grey = UIColor(hex: "757575")
        static let LightGrey = UIColor(hex: "959595")       // 149 149 149
        static let btnGrey = UIColor(hex: "DDDDDD")
        static let BlueLight = UIColor(hex: "55aae5")
        static let BlueSipBorder = UIColor(hex: "3075F2")
        static let Line = UIColor(hex: "d2d2d2") // 210 210 210
        static let LighterGrey = UIColor(hex: "f2f2f2")
        static let LightWhite = UIColor(hex: "f9fafc")
        static let AppGreen = UIColor(hex:"009D89")
        static let BankNameTagGrey = UIColor(hex:"464646")
        static let SnowWhite = UIColor(hex: "FFFFFF")
        static let PaleGrey = UIColor(hex: "F9FAFC")
        static let LightSkyBlue = UIColor(hex: "39C1F0")
        static let DarkSkyBlue = UIColor(hex: "1D617D")
        static let Black = UIColor.black
        static let GrayishWhite = UIColor(hex: "D2D2D2") // 210 210 210
        static let TableSepGray = UIColor(hex: "1d1d26") //29 29 38
        
    }
    
    struct CellIdentifier {
        static let GeneralHeaderCell = "hCell"
        static let GeneralTableCell = "cell"
        static let LoginSignupCombinedCell = "LoginSignupCombinedCell"
        static let LoginInputCell = "LoginInputCell"
    }
    
    struct General {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        static let Tmp = NSTemporaryDirectory()
        static let AnimationDuration = 0.3
    }
    
    struct ScreenNavigationTitle {
        static let HomeScreen = NSLocalizedString("Home", comment: "Home")
    }
    
    struct Entities {
        
    }

    
    struct Notifications {
        static let FundDetailsBottomPageHeight = Notification.Name("FundDetailsBottomPageHeight")
    }
    
}
