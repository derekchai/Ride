//
//  RoutePoint.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import MapKit

struct RoutePoint: Identifiable {
    var id: UUID
    
    var coordinate: CLLocationCoordinate2D
    var speed: CLLocationSpeed
    var altitude: CLLocationDistance
    var timestamp: Date
    
    init(id: UUID = UUID(), coordinate: CLLocationCoordinate2D, speed: CLLocationSpeed, altitude: CLLocationDistance, timestamp: Date) {
        self.id = id
        self.coordinate = coordinate
        self.speed = speed
        self.altitude = altitude
        self.timestamp = timestamp
    }
}
