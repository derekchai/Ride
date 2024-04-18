//
//  CLLocationDistanceExtension.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import CoreLocation

extension CLLocationDistance {
    
    /// Returns a rounded string in metres if `self` is less than 1000 m, and a
    /// rounded string to 2 d.p. in kilometres if `self` is greater.
    func asRoundedKmOrM() -> String {
        if self < 1000 {
            return "\(Int(self)) m"
        }
        
        let kilometres = self / 1000
        
        return "\(String(format: "%.2f", kilometres)) km"
    }
    
    /// Returns the distance, given in m, as km.
    var asKm: Double {
        self / 1000
    }
    
    /// Returns the distance, given in km, as m.
    var km: CLLocationDistance {
        self * 1000
    }
}
