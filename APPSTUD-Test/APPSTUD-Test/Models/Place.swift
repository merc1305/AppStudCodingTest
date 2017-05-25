//
//  Place.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

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

class Place: Object {
    dynamic var photoURL: String?
    dynamic var name: String?
    dynamic var lat: Double = 0.0
    dynamic var long: Double = 0.0
    
//    var location: Location
    
//    init(dict: [String: Any]) {
//        photoURL = dict["photoURL"] as? String
//        name = dict["name"] as? String
//        location = Location.init(dict: dict["location"] as! [String : Double])
//    }
    
//    required init(value: Any, schema: RLMSchema) {
//        fatalError("init(value:schema:) has not been implemented")
//    }
//
//    required init() {
//        fatalError("init() has not been implemented")
//    }
//
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        fatalError("init(realm:schema:) has not been implemented")
//    }
    
    func deleteTicket() -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
}


