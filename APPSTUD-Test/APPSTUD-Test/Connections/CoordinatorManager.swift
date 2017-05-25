//
//  CoordinatorManager.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import MapKit

class CoordinatorManager { //TO start sync cross viewcontrollers
    static let shared = CoordinatorManager()
    var currentLocation: CLLocationCoordinate2D?
    var currentText: String?
    var places: [Place] = []
}
