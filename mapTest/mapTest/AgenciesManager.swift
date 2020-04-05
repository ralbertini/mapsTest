//
//  AgenciesManager.swift
//  mapTest
//
//  Created by Tomate Albertini on 05/04/20.
//  Copyright © 2020 Ronaldo Albertini. All rights reserved.
//

import UIKit
import GooglePlaces

class AgenciesManager: NSObject {

    private let token = GMSAutocompleteSessionToken.init()
    private let placesClient = GMSPlacesClient()
    
    private var mapView:GMSMapView
    
    init(map:GMSMapView) {
        
        self.mapView = map
        super.init()
    }
    
    func searchAgencies() {

        let filter = GMSAutocompleteFilter()
    
        filter.type = .establishment
        
        let visi:GMSVisibleRegion = self.mapView.projection.visibleRegion()
        let bounds: GMSCoordinateBounds = GMSCoordinateBounds(region: visi)
         
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
     
                self.getCoordinates(fromPlaceID: result.placeID)
              }
            }
        })
    }
    
    private func getCoordinates(fromPlaceID:String) {
        
        self.placesClient.fetchPlace(fromPlaceID: fromPlaceID, placeFields: GMSPlaceField(rawValue: GMSPlaceField.all.rawValue)!, sessionToken: self.token) { (place, error) in
        
            self.setMarker(place: place!)
        }
    }
    
    private func setMarker(place: GMSPlace) {
        
        let marker = GMSMarker()
        marker.position = place.coordinate
        marker.snippet = place.name
        marker.title = place.name
        marker.userData = place
        marker.map = self.mapView
    }
}
