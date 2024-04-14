//
//  Route.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import CoreLocation

struct Route: Identifiable {
    let id: UUID
    
    var name: String
    var routePoints: [RoutePoint]
    
    /// The average speed of the activity.
    var averageSpeed: CLLocationSpeed {
        let sum = routePoints.reduce(0) { $0 + $1.speed }
        return sum / Double(routePoints.count)
    }
    
    /// The total distance travelled during the activity.
    var totalDistance: CLLocationDistance {
        var sum: Double = 0
        for i in 0..<routePoints.count - 1 {
            let coordinateA = routePoints[i].coordinate
            let coordinateB = routePoints[i + 1].coordinate
            
            let locationA = CLLocation(latitude: coordinateA.latitude, longitude: coordinateA.longitude)
            let locationB = CLLocation(latitude: coordinateB.latitude, longitude: coordinateB.longitude)
            
            sum += locationA.distance(from: locationB)
        }
        return sum
    }
    
    /// The altitude ascended, in metres.
    var totalAltitudeGain: CLLocationDistance {
        var sum: Double = 0
        for i in 0..<routePoints.count - 1 {
            let altitudeA = routePoints[i].altitude
            let altitudeB = routePoints[i + 1].altitude
            
            guard altitudeA < altitudeB else { continue }
            
            sum += altitudeB - altitudeA
        }
        return sum
    }
    
    /// The altitude descended, in metres.
    var totalAltitudeLoss: CLLocationDistance {
        var sum: Double = 0
        for i in 0..<routePoints.count - 1 {
            let altitudeA = routePoints[i].altitude
            let altitudeB = routePoints[i + 1].altitude
            
            guard altitudeA > altitudeB else { continue }
            
            sum += altitudeA - altitudeB
        }
        return sum
    }
    
    /// The duration of the activity, in seconds.
    var duration: TimeInterval {
        guard !routePoints.isEmpty else { return TimeInterval(0) }
        
        return routePoints.last!.timestamp - routePoints.first!.timestamp
    }
    
    /// The `Date` at which the activity began.
    var startTimestamp: Date? {
        routePoints.first?.timestamp
    }
    
    /// The `Date` at which the activity finished.
    var endTimestamp: Date? {
        routePoints.last?.timestamp
    }
    
    init(id: UUID = UUID(), name: String, routePoints: [RoutePoint]) {
        self.id = id
        self.name = name
        self.routePoints = routePoints
    }
}

extension Route {
    static let sampleRoute = Route(
        name: "Sample Route",
        routePoints: [
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 36.8509, longitude: 174.7645), speed: 0, altitude: 20, timestamp: Date.now - TimeInterval(1855)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.3725, longitude: 174.1116), speed: 23.4, altitude: 18.3, timestamp: Date.now - TimeInterval(1641)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.1729, longitude: 174.4692), speed: 29.22, altitude: 3.92, timestamp: Date.now - TimeInterval(1225)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 34.9992, longitude: 174.8289), speed: 14.5, altitude: 24.47, timestamp: Date.now - TimeInterval(752)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.2727, longitude: 175.1124), speed: 8.02, altitude: 65.32, timestamp: Date.now - TimeInterval(243)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.8723, longitude: 175.1424), speed: 15.31, altitude: 72.11, timestamp: Date.now),
        ]
    )
    
    static let sampleData = [
        Route(
            name: "Sample Route 1",
            routePoints: [
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 36.8509, longitude: 174.7645), speed: 0, altitude: 20, timestamp: Date.now - TimeInterval(1855)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.3725, longitude: 174.1116), speed: 23.4, altitude: 18.3, timestamp: Date.now - TimeInterval(1641)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.1729, longitude: 174.4692), speed: 29.22, altitude: 3.92, timestamp: Date.now - TimeInterval(1225)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 34.9992, longitude: 174.8289), speed: 14.5, altitude: 24.47, timestamp: Date.now - TimeInterval(752)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.2727, longitude: 175.1124), speed: 8.02, altitude: 65.32, timestamp: Date.now - TimeInterval(243)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.8723, longitude: 175.1424), speed: 15.31, altitude: 72.11, timestamp: Date.now),
            ]
        ),
        Route(
            name: "Sample Route 2",
            routePoints: [
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 36.8509, longitude: 174.7645), speed: 0, altitude: 20, timestamp: Date.now - TimeInterval(1855)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.3725, longitude: 174.1116), speed: 23.4, altitude: 18.3, timestamp: Date.now - TimeInterval(1641)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.1729, longitude: 174.4692), speed: 29.22, altitude: 3.92, timestamp: Date.now - TimeInterval(1225)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 34.9992, longitude: 174.8289), speed: 14.5, altitude: 24.47, timestamp: Date.now - TimeInterval(752)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.2727, longitude: 175.1124), speed: 8.02, altitude: 65.32, timestamp: Date.now - TimeInterval(243)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: 35.8723, longitude: 175.1424), speed: 15.31, altitude: 72.11, timestamp: Date.now),
            ]
        )
    ]
}
