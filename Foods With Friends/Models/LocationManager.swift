//
//  LocationManager.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/17/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject{

    @Published var location: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    
    override init(){
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_manager: CLLocationManager, didUpdateLocations locations: [CLLocationCoordinate2D]) {
        
        guard let location = locations.last else {return}
        
        
        DispatchQueue.main.async { [weak self] in
           self?.location = location
        }
        
    }
}
