//
//  MapViewController.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: BaseViewController, LocationUpdateProtocol {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var inputTextField: UITextField!
    private var currentLocation: CLLocationCoordinate2D?
    private var currentTextInput: String?
    
//    private gesture: UITapGes
    
    var timerStartRequest: Timer?
    private var isRequesting = false
  
    override func setupUI() {
        title = "Map"
        mapView.showsUserLocation = true
        mapView.delegate = self
        inputTextField.delegate = self
        ASLocationManager.sharedInstance.locationUpdateDelegate = self
        ASLocationManager.sharedInstance.startLocationService()
        validateViewDisplay()
    }
    
    
    private func validateViewDisplay() {
        if ASLocationManager.sharedInstance.isLocationServiceAvailable() {
            if let curLocation = currentLocation {
                mapView.setCenter(curLocation, animated: true)
                let span = MKCoordinateSpanMake(1, 1)
                let region = MKCoordinateRegion(center: curLocation, span: span)
                mapView.setRegion(region, animated: true)
            }
            
            inputTextField.isHidden = true
            inputTextField.text = ""
            startRequestService()
        } else { //Animate alternative view
            inputTextField.isHidden = false
            inputTextField.alpha = 0.0
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.inputTextField.alpha = 0.5
                }, completion: { [weak self] (success) in
                    self?.inputTextField.alpha = 1
            })
        }
    }
    
    
    deinit {
        invalidateTimer()
    }
    
    
    @objc
    private func startRequestService() {
        if !isRequesting {
            isRequesting = true
            //Start request and callback with isRuesting = false to start new request
        }
    }
    
    
    
    @IBAction func centerLocation(_ sender: Any) {
        ASLocationManager.sharedInstance.startLocationService()
    }
    
    
    func startTimerRequest() {
        invalidateTimer()
        timerStartRequest = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startRequestService), userInfo: nil, repeats: false)
    }
    
    func invalidateTimer() {
        if let timer = timerStartRequest {
            timer.invalidate()
        }
    }
    
    //Location update delegate: Return user current location
    func locationUpdate(location: CLLocation) {
        currentLocation = location.coordinate
        ASLocationManager.sharedInstance.stopLocationService()
        validateViewDisplay()
    }
}

extension MapViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == false && textField.text?.replacingOccurrences(of: " " , with: "").characters.count != 0 {
            startTimerRequest()
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}

