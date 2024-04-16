//
//  RoutePoint.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import MapKit
import SwiftUI

struct RoutePoint: Identifiable, Equatable {
    /// Returns `true` if both sides' latitudes and longitudes are equal.
    ///
    /// `id`, `speed`, `altitude`, and `timestamp` are ignored.
    static func == (lhs: RoutePoint, rhs: RoutePoint) -> Bool {
        if lhs.coordinate.latitude == rhs.coordinate.latitude 
            && lhs.coordinate.longitude == rhs.coordinate.longitude {
            return true
        } else {
            return false
        }
    }
    
    var id: UUID
    
    var coordinate: CLLocationCoordinate2D
    
    /// Speed in metres per second.
    var speed: CLLocationSpeed
    
    /// Altitude in metres.
    var altitude: CLLocationDistance
    
    /// The timestamp when this point was recorded.
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
    var maxSpeed: CLLocationSpeed? {
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
    
    /// The distance travelled (i.e. not displacement) between two indices of
    /// `[RoutePoint]`, in metres.
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
    
    /// Returns a `[CLLocationDistance]` where each item is its distance
    /// from the first point in metres, in ascending order.
    var distances: [CLLocationDistance] {
        var output: [CLLocationDistance] = []
        
        for i in self.indices {
            output.append(self.distanceBetween(i2: i))
        }
         return output
    }
    
    /// Returns a `[CLLocationDistance]` where each item that point's
    /// altitude.
    var altitudes: [CLLocationDistance] {
        self.map { $0.altitude }
    }
    
    func pointBeforeDistance(distance: CLLocationDistance) -> RoutePoint? {
        guard !self.isEmpty else { return nil }
        
        var tempPoint: RoutePoint = self.first!
        
        for i in self.indices {
            if self.distanceBetween(i2: i) < distance {
                tempPoint = self[i]
            } else {
                return tempPoint
            }
        }
        
        return nil
    }
}
