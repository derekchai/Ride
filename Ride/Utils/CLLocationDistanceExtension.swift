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
    
    var kilometres: Double {
        self / 1000
    }
}
