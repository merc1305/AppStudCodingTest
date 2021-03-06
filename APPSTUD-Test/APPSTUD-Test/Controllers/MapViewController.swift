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
    
    private var gesture: UIGestureRecognizer!
    
    var timerStartRequest: Timer?
    private var isRequesting = false
  
    override func setupUI() {
        title = "Map"
        mapView.showsUserLocation = true
        mapView.delegate = self
        inputTextField.delegate = self
        ASLocationManager.shared.locationUpdateDelegate = self
        ASLocationManager.shared.startLocationService()
        validateViewDisplay()
        
        gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    
    @objc
    private func dismissKeyboard() {
        inputTextField.resignFirstResponder()
    }
    
    private func validateViewDisplay() {
        if ASLocationManager.shared.isLocationServiceAvailable() {
            if let curLocation = currentLocation {
                mapView.setCenter(curLocation, animated: true)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegion(center: curLocation, span: span)
                mapView.setRegion(region, animated: true)
            }
            
            inputTextField.isHidden = true
            inputTextField.text = ""
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
    
    
    override func startRequestService() {
        super.startRequestService()
        if !isRequesting {
            isRequesting = true
            //Start request and callback with isRuesting = false to start new request
            if let curLocaiton = currentLocation {
                let location = Location(lat: curLocaiton.latitude, long: curLocaiton.longitude)
                showLoadingIndicator()
                APIConnectionManager.shared.getPlacesNear(location: location, type: "bar", radius: 2000, success: { [weak self] places in
                    self?.handleResponsePlaces(places: places)
                })
            }
        }
    }
    

    override func startRequestByName() {
        super.startRequestByName()
        if !isRequesting {
            isRequesting = true
            if let input = inputTextField.text {
                CoordinatorManager.shared.currentText = input
                APIConnectionManager.shared.searchPlaces(input: input, success: { [weak self] (places) in
                    self?.handleResponsePlaces(places: places)
                })
            }
        }
    }
    
    private func handleResponsePlaces(places: [Place]) {
        isRequesting = false
        CoordinatorManager.shared.places = places
        Utils.runOnMainThread {
            mapView.removeAnnotations(mapView.annotations)
            for place in places {
                let annotation = ASAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.lat, longitude: place.long))
                annotation.imageUrl = place.photoURL
                mapView.addAnnotation(annotation)
            }
            inputTextField.resignFirstResponder()
            hideLoadingIndicator()
        }
    }
    
    
    
    @IBAction func centerLocation(_ sender: Any) {
        ASLocationManager.shared.startLocationService()
    }
    
    
    func startTimerRequest() {
        invalidateTimer()
        timerStartRequest = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startRequestByName), userInfo: nil, repeats: false)
    }
    
    func invalidateTimer() {
        if let timer = timerStartRequest {
            timer.invalidate()
        }
    }
    
    //Location update delegate: Return user current location
    func locationUpdate(location: CLLocation) {
        currentLocation = location.coordinate
        ASLocationManager.shared.stopLocationService()
        CoordinatorManager.shared.currentLocation = currentLocation
        validateViewDisplay()
        startRequestService()
    }
}

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty == false && textField.text?.replacingOccurrences(of: " " , with: "").characters.count != 0 {
            startTimerRequest()
        }
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin") as? ASAnnotationView
        if annotationView == nil {
            annotationView = ASAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.alreadyLoad = false
        annotationView?.canShowCallout = false
        annotationView?.layoutSubviews()
        annotationView?.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        annotationView?.fullyRound(60, borderColor: UIColor.black, borderWidth: 1)
        return annotationView
    }
}

