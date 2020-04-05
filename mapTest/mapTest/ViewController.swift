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

    let placesClient = GMSPlacesClient()
    let mapView = GMSMapView()
    let locationMgr: LocationManager = LocationManager()
    lazy var agenciesMgr: AgenciesManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupConstraints()
        
        self.agenciesMgr = AgenciesManager(map: self.mapView)
        
        self.locationMgr.delegate = self
        self.locationMgr.getAuthorization()
    }
    
    private func setupViews() {
        
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

    private func mapPosition(location:CLLocation) {
        self.mapView.animate(toLocation: location.coordinate)
    }
}

extension ViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        if let place = marker.userData as? GMSPlace {
            
            let detailsViewController: DetailsViewController = DetailsViewController()
            detailsViewController.place = place
            
            let nav = UINavigationController(rootViewController: detailsViewController)
            self.present(nav, animated: true, completion: nil)
            
            return true
        }
 
        return false
    }
}

extension ViewController: LocationManagetProtocol {
    
    func locationChanged(currentLocation: CLLocation) {
        
        self.mapPosition(location: currentLocation)
        self.mapView.camera = GMSCameraPosition.camera(withTarget: currentLocation.coordinate, zoom: 11.0)
        self.agenciesMgr?.searchAgencies()
    }
}

