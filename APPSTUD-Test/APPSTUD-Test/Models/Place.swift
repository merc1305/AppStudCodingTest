//
//  Place.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation

struct Location {
    let lat: Double
    let long: Double
    
    init(dict: [String: Double]) {
        lat = dict["lat"]!
        long = dict["lng"]!
    }
    
    init(lat: Double, long: Double) {
        self.lat = lat;
        self.long = long
    }
}

class Place {
    let photoURL: String?
    let name: String?
    let location: Location
    
    init(dict: [String: Any]) {
        photoURL = dict["photoURL"] as? String
        name = dict["name"] as? String
        location = Location.init(dict: dict["location"] as! [String : Double])
    }
}


