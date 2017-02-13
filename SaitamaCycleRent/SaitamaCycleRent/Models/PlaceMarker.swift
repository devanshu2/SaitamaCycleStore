//
//  PlaceMarker.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 13/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import GoogleMaps

public class PlaceMarker: NSObject, GMUClusterItem {
    public var id:String?
    public var name: String!
    public var position: CLLocationCoordinate2D
    init(withPlace place:Place) {
        self.position = place.location!
        self.name = place.name
        self.id = place.id
    }
}
