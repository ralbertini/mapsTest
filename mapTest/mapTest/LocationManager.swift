//
//  LocationManager.swift
//  mapTest
//
//  Created by Tomate Albertini on 05/04/20.
//  Copyright © 2020 Ronaldo Albertini. All rights reserved.
//

import UIKit

protocol LocationManagetProtocol {
    
    func locationChanged(currentLocation: CLLocation)
    
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var delegate: LocationManagetProtocol?
    
    let locationManager = CLLocationManager()
    
    func getAuthorization() {
    
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return

        case .denied, .restricted:

            return
        case .authorizedAlways, .authorizedWhenInUse:
            break

        @unknown default:
            break
        }
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        if let currentLocation = locations.last {
            
            self.locationChanged(currentLocation: currentLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

extension LocationManager:LocationManagetProtocol {
    
    func locationChanged(currentLocation: CLLocation) {
        
        delegate?.locationChanged(currentLocation: currentLocation)
    }
}
