//
//  LocationService.swift
//  techchallenge_jingluo
//
//  Created by JINGLUO on 27/1/18.
//  Copyright © 2018 JINGLUO. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService {
    
    var currentLocation = CLLocation()
    
    init(_ location: (Double, Double)) {
        currentLocation = CLLocation(latitude: location.0, longitude: location.1)
    }
    
    func fetchCity(_ completion: @escaping (String) -> ()) {
        self.fetchCity(currentLocation, completion: completion)
    }
    
    func fetchCity(_ location: CLLocation, completion: @escaping (String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print(error)
            } else if let city = placemarks?.first?.locality {
                completion(city)
            }
        }
    }
}

