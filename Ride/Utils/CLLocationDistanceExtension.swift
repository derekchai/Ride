//
//  CLLocationDistanceExtension.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import CoreLocation

extension CLLocationDistance {
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
