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
    
    var averageSpeed: CLLocationSpeed {
        let sum = routePoints.reduce(0) { $0 + $1.speed }
        return sum / Double(routePoints.count)
    }
    
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
    
    var duration: TimeInterval {
        guard !routePoints.isEmpty else { return TimeInterval(0) }
        
        return routePoints.last!.timestamp - routePoints.first!.timestamp
    }
    
    init(id: UUID = UUID(), name: String, routePoints: [RoutePoint]) {
        self.id = id
        self.name = name
        self.routePoints = routePoints
    }
}
