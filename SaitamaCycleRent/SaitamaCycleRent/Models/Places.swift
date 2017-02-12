//
//  Places.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 13/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

public class PlaceMarker: GMSMarker {
    public var id:String?
    convenience init(withPlace place:Place) {
        self.init()
        self.position = place.location!
        self.title = place.name
        self.id = place.id
    }
}

public class Place: NSObject {
    public var location: CLLocationCoordinate2D?
    public var id:String?
    public var name:String?
    
    private let kLocation = "location"
    private let kLatitude = "lat"
    private let kLongitude = "lng"
    private let kID = "id"
    private let kName = "name"
    
    convenience init?(dataDictionary data:[String:Any]) {
        self.init()
        if let locationData = data[self.kLocation] as? [String:Double] {
            let latitude = locationData[self.kLatitude]
            let longitude = locationData[self.kLongitude]
            self.location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        }
        else {
            return nil
        }
        if let theID = data[self.kID] as? String {
            self.id = theID
        }
        else {
            return nil
        }
        if let theName = data[self.kName] as? String {
            self.name = theName
        }
        else {
            return nil
        }
    }
}

public class Places: BaseModel {
    private let kAPIURL = URL(string: Constants.API.Server + Constants.API.EndPoint.Places)
    private let kResults = "results"
    public var allPlaces:Array<Place>?
    
    public func getPlaces(withCompletionHandler completionHandler: @escaping (Array<Place>?, Error?, String?) -> Swift.Void) {
        self.apiManager.getData(apiEndpoint: kAPIURL!) { (data, response, error) in
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
                        debugPrint(apiResponseData)
                        if let results = apiResponseData[self.kResults] as? Array<Dictionary<String, Any>> {
                            var thePlaces:Array<Place> = []
                            for singlePlaceData in results {
                                if let singlePlace = Place(dataDictionary: singlePlaceData) {
                                    thePlaces.append(singlePlace)
                                }
                            }
                            self.allPlaces = thePlaces
                            completionHandler(thePlaces, nil, nil)
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
