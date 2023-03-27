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
 //   @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion()
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


//extension MKCoordinateRegion {
//    static func defaultRegion() -> MKCoordinateRegion{
//        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 39.9526, longitude: 75.1652), latitudinalMeters: 1000, longitudinalMeters: 1000)
//    }
//}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        
        
        DispatchQueue.main.async { [weak self] in
           self?.location = location
      //      self?.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        }
        
    }
}
