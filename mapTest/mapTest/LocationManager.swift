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
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)

         //   present(alert, animated: true, completion: nil)
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
