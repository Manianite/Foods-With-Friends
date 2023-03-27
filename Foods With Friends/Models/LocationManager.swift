//
//  LocationManager.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/17/23.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject{

    @Published var location: CLLocation?
    static let shared = LocationManager()
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
    
    func locationManager(_manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        
        
        DispatchQueue.main.async { [weak self] in
           self?.location = location
        }
        
    }
}
