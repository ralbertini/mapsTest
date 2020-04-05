//
//  ViewController.swift
//  mapTest
//
//  Created by Tomate Albertini on 04/04/20.
//  Copyright © 2020 Ronaldo Albertini. All rights reserved.
//

import UIKit
import GooglePlaces
import SnapKit
import FBSnapshotTestCase

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    let placesClient = GMSPlacesClient()
    let mapView = GMSMapView()
    var firstLocationUpdate = false
    
    func setupViews() {
        
        self.view.addSubview(self.mapView)
        self.mapView.delegate = self
        self.mapView.settings.compassButton = true
        self.mapView.settings.myLocationButton = true
        self.mapView.isMyLocationEnabled = true
        
        
    }
    
    private func setupConstraints() {
        
        self.mapView.snp.makeConstraints { (make) in
            make.leading.top.bottom.trailing.equalToSuperview()
        }
    }
    
    func getLocation(_ sender: Any) {
    
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                return

      
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break

        @unknown default:
            break
        }
        
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupConstraints()
        
        self.getLocation(self)
        
//        self.procura()
//        self.lista()
        
    
    }
    
    func lista() {
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.coordinate.rawValue))!
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields, callback: {
          (placeLikelihoodList: Array<GMSPlaceLikelihood>?, error: Error?) in
          if let error = error {
            print("An error occurred: \(error.localizedDescription)")
            return
          }
            
            
          if let placeLikelihoodList = placeLikelihoodList {
            
       
            
            for likelihood in placeLikelihoodList {
                
                let place = likelihood.place
                let marker = GMSMarker()
                marker.position = place.coordinate
                marker.snippet = place.name
                marker.title = place.name
                marker.userData = place
                marker.map = self.mapView
            }
          }
        })
    }
    
    func procura() {
        
        let token = GMSAutocompleteSessionToken.init()

        // Create a type filter.
        let filter = GMSAutocompleteFilter()
    
        filter.type = .establishment

//        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: GMSPlaceField.all) { (placelist, error) in
//
//            if let results = placelist {
//              for result in results {
//                print("Result \(result)")
//
//
//              }
//            }
//
//        }
        

        
        let visi:GMSVisibleRegion = self.mapView.projection.visibleRegion()
        let bounds: GMSCoordinateBounds = GMSCoordinateBounds(region: visi)
        
//        GMSVisibleRegion region = _mapView.projection.visibleRegion;
//        GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithRegion:region];
        
        
        placesClient.findAutocompletePredictions(fromQuery: "agência itaú",
                                                 bounds: bounds,
                                                 boundsMode: GMSAutocompleteBoundsMode.bias,
                                                  filter: filter,
                                                  sessionToken: token,
                                                  callback: { (results, error) in
            if let error = error {
              print("Autocomplete error: \(error)")
              return
            }
            if let results = results {
              for result in results {
                print("Result \(result.attributedFullText) with placeID \(result.placeID)")
              
                self.getCoordinates(fromPlaceID: result.placeID)
              }
            }
        })

    }

    func getCoordinates(fromPlaceID:String) {
        
        self.placesClient.fetchPlace(fromPlaceID: fromPlaceID, placeFields: GMSPlaceField(rawValue: GMSPlaceField.all.rawValue)!, sessionToken: GMSAutocompleteSessionToken()) { (place, error) in
//            print(place)
            
            self.setMarker(place: place!)
            
           
        }
        
    }
    
    func setMarker(place: GMSPlace) {
        
        let marker = GMSMarker()
        marker.position = place.coordinate
        marker.snippet = place.name
        marker.title = place.name
        marker.userData = place
        marker.map = self.mapView
        
    }
    
    func mapPosition(location:CLLocation) {
        self.mapView.animate(toLocation: location.coordinate)
    }
    
}

extension ViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.title)
        let place = marker.userData as! GMSPlace
        print(place.name)
        
        
        let detailsViewController: DetailsViewController = DetailsViewController()
                   detailsViewController.place = place
                   
                   let nav = UINavigationController(rootViewController: detailsViewController)
                   self.present(nav, animated: true, completion: nil)
        
        
        return true
    }
    
}

extension ViewController : CLLocationManagerDelegate {
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        if let currentLocation = locations.last {
        print("Current location: \(currentLocation)")
            self.mapPosition(location: currentLocation)
            
            if !self.firstLocationUpdate {
                self.firstLocationUpdate = true
                self.mapView.camera = GMSCameraPosition.camera(withTarget: currentLocation.coordinate, zoom: 13.0)
                
                
            } else {

                self.procura()
                
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
