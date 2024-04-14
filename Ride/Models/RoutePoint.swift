//
//  RoutePoint.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import MapKit

struct RoutePoint {
    var coordinate: CLLocationCoordinate2D
    var speed: CLLocationSpeed
    var altitude: CLLocationDistance
    var timestamp: Date
}
