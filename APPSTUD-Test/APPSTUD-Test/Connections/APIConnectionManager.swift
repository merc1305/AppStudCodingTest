//
//  APIConnectionManager.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import Alamofire

let APIKey = "AIzaSyANmCgSYXr8m6g17pU_YF0PQ0FgbwT7Rb8"

class APIConnectionManager {

    let urlSearchPlaceString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    
//    class func getPlaces() {
//        Alamofire.request(urlSearchPlaceString, parameters: ["params":"params"], encoding: JSONEncoding.default).responseJSON{ response in
//            if response.result.isFailure{
//                
//            } else {
//                if let jsons = response.result.value as? [[String:Any]]{
//                    var places = [Place]()
//                    for json in jsons as [String : Any]{
//                        
//                    }
//                    
//                    success?(places)
//                }
//            }
//        }
//    }
}

