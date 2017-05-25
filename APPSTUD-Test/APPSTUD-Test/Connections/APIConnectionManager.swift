//
//  APIConnectionManager.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

let APIKey = "AIzaSyANmCgSYXr8m6g17pU_YF0PQ0FgbwT7Rb8"

enum URLName {
    case SearchPlaceLocation
    case SearchPlaceString
    case Photo(reference: String?)
    case LocationForPlace
}

class APIConnectionManager {
    static let shared = APIConnectionManager()
    
    func urlString(urlName: URLName) -> String {
        switch urlName {
        case .SearchPlaceLocation:
            return "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        case .SearchPlaceString:
            return "https://maps.googleapis.com/maps/api/place/autocomplete/json"
        case .Photo(let reference):
            if reference != nil {
                return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&key:\(APIKey)&photoreference:\(reference!)"
            } else {
                return ""
            }
        case .LocationForPlace:
            return "https://maps.googleapis.com/maps/api/place/details/json"
        }
        
    }
    
    //Get Bars around current user location with 2KMs
    func getPlacesNear(location: Location, type: String, radius: Double, success: (([Place]) -> Void)?) {
        Alamofire.request(urlString(urlName: .SearchPlaceLocation), method: .get, parameters:["location": "\(location.lat), \(location.long)", "type": type, "radius": radius, "key": APIKey]).responseJSON { response in
            
            if response.result.isFailure{
                print("failure")
            } else {
                if let jsons = ((response.result.value as! [String:Any])["results"] as? [[String:Any]]){
                    print("json: \(jsons)")
                    var places = [Place]()
                    jsons.forEach({ (json) in
                        guard
                        let name = json["name"],
                        let location = (json["geometry"] as! [String: Any])["location"]
                        else { return }
                        
                        let photoURL = self.urlString(urlName: .Photo(reference: ((json["photos"] as? [[String:Any]])?[0])?["photo_reference"] as? String ))
                        
                        let locationStruct = Location(dict: location as! [String : Double])
                        
                        let place = Place()
                        place.name = name as? String
                        place.photoURL = photoURL
                        place.lat = locationStruct.lat
                        place.long = locationStruct.long
                        
                        places.append(place)
                    })
                    
                    success?(places)
                    
                    let realm = try! Realm()
                    try! realm.write {
                        realm.deleteAll()
                        realm.add(places)
                    }
                }
            }
        }
    }
    
    //Get location by placeId
    func getLocationFor(placeId: String, success: (([Place]) -> Void)?) {
        Alamofire.request(urlString(urlName: .LocationForPlace), method: .get, parameters:["placeid": placeId, "key": APIKey]).responseJSON {
            response in
            
            if response.result.isFailure{
                print("failure")
            } else {
                if let result = ((response.result.value as! [String: Any])["result"] as? [String: Any]) {
                    let location = Location(dict: (result["geometry"] as! [String: Any])["location"] as! [String: Double] )
                    self.getPlacesNear(location: location, type: "bar", radius: 2000, success: { places in
                        success?(places)
                    })
                }
            }
        }
    }
    
    //Search place
    func searchPlaces(input: String, success: (([Place]) -> Void)?) {
        Alamofire.request(urlString(urlName: .SearchPlaceString), method: .get, parameters:["input":input, "types": "geocode", "key": APIKey]).responseJSON {
            response in
            if response.result.isFailure{
                print("failure")
            } else {
                if let places = ((response.result.value as! [String: Any])["predictions"] as? [[String: Any]]) {
                    if places.count > 0 {
                        let placeId = places[0]["place_id"] as! String
                        self.getLocationFor(placeId: placeId, success: { places in
                            success?(places)
                        })
                    }
                }
            }
            
            
        }
        
    }
}

