//
//  ASLocationManager.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationUpdateProtocol {
    func locationUpdate(location: CLLocation)
}

class ASLocationManager: NSObject {
    static let sharedInstance = ASLocationManager()
    
    private var locationManager: CLLocationManager!
    var lastKnownCoordinate: CLLocationCoordinate2D
    var locationUpdateDelegate: LocationUpdateProtocol?
    
    //Override init from NSObject confirm protocol
    private override init() {
        lastKnownCoordinate = kCLLocationCoordinate2DInvalid//No initial coordinate value
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func isLocationServiceAvailable() -> Bool {
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            return true
        }
        return false
    }
    
    /// Request authorization when service not available
    func requestLocationServiceIfNeeded() {
        if !isLocationServiceAvailable() {
            locationManager.requestWhenInUseAuthorization()
            
        }
    }
    
    func startLocationService() {
        locationManager.startUpdatingLocation();
    }
    
    func stopLocationService() {
        locationManager.stopUpdatingLocation()
    }

}

extension ASLocationManager: CLLocationManagerDelegate {
    // MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last;
        if let safelocation = location {
            lastKnownCoordinate = safelocation.coordinate;
            if let del = locationUpdateDelegate {
                del.locationUpdate(location: safelocation)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways || status == .authorizedWhenInUse) {
            startLocationService()
        } else if (status == .notDetermined) {//In case of notDetermined -> Just start normally
            startLocationService()
        } else { // Location service disabled -> Display alert
            
        }
    }
}
