//
//  RoutePoint.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import MapKit
import SwiftUI

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

extension [RoutePoint] {
    /// Returns the maximum `speed` from the array of `RoutePoint`s.
    var maxSpeed: Double? {
        let speeds = self.map { $0.speed }
        return speeds.max()
    }
    
    /// The average speed of the activity.
    var averageSpeed: CLLocationSpeed {
        let sum = self.reduce(0) { $0 + $1.speed }
        return sum / Double(self.count)
    }
    
    /// The total distance travelled during the activity.
    var totalDistance: CLLocationDistance {
        var sum: Double = 0
        for i in 0..<self.count - 1 {
            let coordinateA = self[i].coordinate
            let coordinateB = self[i + 1].coordinate
            
            let locationA = CLLocation(latitude: coordinateA.latitude, longitude: coordinateA.longitude)
            let locationB = CLLocation(latitude: coordinateB.latitude, longitude: coordinateB.longitude)
            
            sum += locationA.distance(from: locationB)
        }
        return sum
    }
    
    /// The altitude ascended, in metres.
    var totalAltitudeGain: CLLocationDistance {
        var sum: Double = 0
        for i in 0..<self.count - 1 {
            let altitudeA = self[i].altitude
            let altitudeB = self[i + 1].altitude
            
            guard altitudeA < altitudeB else { continue }
            
            sum += altitudeB - altitudeA
        }
        return sum
    }
    
    /// The altitude descended, in metres.
    var totalAltitudeLoss: CLLocationDistance {
        var sum: Double = 0
        for i in 0..<self.count - 1 {
            let altitudeA = self[i].altitude
            let altitudeB = self[i + 1].altitude
            
            guard altitudeA > altitudeB else { continue }
            
            sum += altitudeA - altitudeB
        }
        return sum
    }
    
    /// The duration of the activity, in seconds.
    var duration: TimeInterval {
        guard !self.isEmpty else { return TimeInterval(0) }
        
        return self.last!.timestamp - self.first!.timestamp
    }
    
    /// The `Date` at which the activity began.
    var startTimestamp: Date? {
        self.first?.timestamp
    }
    
    /// The `Date` at which the activity finished.
    var endTimestamp: Date? {
        self.last?.timestamp
    }
    
    /// The distance travelled (i.e. not displacement) between two indices of `[RoutePoint]`, in metres.
    ///
    /// `i1 = 0` (starting point) by default.
    func distanceBetween(i1: Int = 0, i2: Int)  -> CLLocationDistance {
        var sum: Double = 0
        for i in i1..<i2 {
            let coordinateA = self[i].coordinate
            let coordinateB = self[i + 1].coordinate
            
            let locationA = CLLocation(latitude: coordinateA.latitude, longitude: coordinateA.longitude)
            let locationB = CLLocation(latitude: coordinateB.latitude, longitude: coordinateB.longitude)
            
            sum += locationA.distance(from: locationB)
        }
        return sum
    }
}
