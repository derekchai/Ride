//
//  RoutePoint.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import MapKit
import SwiftUI
import SwiftData

class RoutePoint: Identifiable, Codable, Equatable {
    static func == (lhs: RoutePoint, rhs: RoutePoint) -> Bool {
        return lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude
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
    
    enum CodingKeys: CodingKey {
        case _id
        case _coordinate
        case _speed
        case _altitude
        case _timestamp
        case _$backingData
        case _$observationRegistrar
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: ._id)
        coordinate = try container.decode(CLLocationCoordinate2D.self, forKey: ._coordinate)
        speed = try container.decode(CLLocationSpeed.self, forKey: ._speed)
        altitude = try container.decode(CLLocationDistance.self, forKey: ._altitude)
        timestamp = try container.decode(Date.self, forKey: ._timestamp)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(coordinate, forKey: ._coordinate)
        try container.encode(speed, forKey: ._speed)
        try container.encode(altitude, forKey: ._altitude)
        try container.encode(timestamp, forKey: ._timestamp)
    }
}

extension [RoutePoint] {
    /// Returns the maximum `speed` from the array of `RoutePoint`s.
    var maxSpeed: CLLocationSpeed? {
        return self.map { $0.speed }.max()
    }
    
    /// The average speed of the route, in metres per second.
    var averageSpeed: CLLocationSpeed {
        return self.totalDistance / self.duration
    }
    
    /// The total distance travelled during the activity.
    var totalDistance: CLLocationDistance {
        guard !self.isEmpty else { return 0 }
        
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
        guard !self.isEmpty else { return 0 }
        
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
        guard !self.isEmpty else { return 0 }

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
    
    
    /// The distance travelled (not displacement) between two indices within the
    /// `[RoutePoint]`.
    /// - Parameters:
    ///   - i1: Index of starting point.
    ///   - i2: Index of ending point.
    /// - Returns: Distance travelled from the starting point to the ending
    /// point, in metres.
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
    
    /// Returns the first `RoutePoint` before `distance` metres travelled within
    /// the `[RoutePoint]`. Useful for applications such as snapping to an actual
    /// point within the `[RoutePoint]` within a map, from a continuous distance
    /// slider.
    /// - Parameter distance: In metres, before which the first `Point` is returned.
    /// - Returns: The first `RoutePoint` before `distance` metres travelled
    /// within the list.
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
