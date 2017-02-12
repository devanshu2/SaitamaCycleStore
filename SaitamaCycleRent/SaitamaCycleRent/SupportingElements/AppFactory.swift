//
//  AppFactory.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

public class AppFactory: NSObject {
    
    static let shared : AppFactory = {
        let instance = AppFactory()
        return instance
    }()
    
    public func configureGoogleMapsOnAppStart(forApplication application: UIApplication) {
        GMSServices.provideAPIKey(Constants.Google.APIKey)
        GMSPlacesClient.provideAPIKey(Constants.Google.APIKey)
    }
    
    public func signOutUser() {
        UserDefaults.standard.removeObject(forKey: Constants.kAccessToken)
        UserDefaults.standard.synchronize()
    }
    
    public func setUserToken(_ token:String) {
        UserDefaults.standard.set(token, forKey: Constants.kAccessToken)
        UserDefaults.standard.synchronize()
    }
    
    public func getCurrentUserToken() -> String? {
        if let token = UserDefaults.standard.value(forKey: Constants.kAccessToken) as? String {
            return token
        }
        return nil
    }
}
