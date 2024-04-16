//
//  CLLocationSpeedExtension.swift
//  Ride
//
//  Created by Derek Chai on 16/04/2024.
//

import Foundation
import CoreLocation

extension CLLocationSpeed {
    /// Returns the speed, given in m/s, as km/h.
    var asKmH: Double {
        self * 3.6
    }
    
    /// Returns the speed, given in km/h, in m/s.
    var kmH: CLLocationSpeed {
        self / 3.6
    }
}
