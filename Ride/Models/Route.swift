//
//  Route.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI
import SwiftData

@Model
class Route: Identifiable, Codable {
    let id: UUID
    
    var name: String = ""
    var points: [RoutePoint] = []
    
    var endTimestamp: Date {
        self.points.endTimestamp ?? Date.now
    }
    
    var totalDistance: CLLocationDistance {
        self.points.totalDistance
    }
    
    init(id: UUID = UUID(), name: String, routePoints: [RoutePoint]) {
        self.id = id
        self.name = name
        self.points = routePoints
    }
    
    enum CodingKeys: CodingKey {
        case _id
        case _name
        case _points
        case _$backingData
        case _$observationRegistrar
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: ._id)
        name = try container.decode(String.self, forKey: ._name)
        points = try container.decode([RoutePoint].self, forKey: ._points)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(name, forKey: ._name)
        try container.encode(points, forKey: ._points)
    }
}

extension Route {
    static let sampleRoute = Route(
        name: "Sample Route",
        routePoints: [
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -36.8509, longitude: 174.7645), speed: 0, altitude: 20, timestamp: Date.now - TimeInterval(1855)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.3725, longitude: 174.1116), speed: 23.4, altitude: 18.3, timestamp: Date.now - TimeInterval(1641)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.1729, longitude: 174.4692), speed: 29.22, altitude: 3.92, timestamp: Date.now - TimeInterval(1225)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -34.9992, longitude: 174.8289), speed: 14.5, altitude: 24.47, timestamp: Date.now - TimeInterval(752)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.2727, longitude: 175.1124), speed: 8.02, altitude: 65.32, timestamp: Date.now - TimeInterval(243)),
            RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.8723, longitude: 175.1424), speed: 15.31, altitude: 72.11, timestamp: Date.now),
        ]
    )
    
    static let sampleData = [
        Route(
            name: "Sample Route 1",
            routePoints: [
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -36.8509, longitude: 174.7645), speed: 0, altitude: 20, timestamp: Date.now - TimeInterval(1855)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.3725, longitude: 174.1116), speed: 23.4, altitude: 18.3, timestamp: Date.now - TimeInterval(1641)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.1729, longitude: 174.4692), speed: 29.22, altitude: 3.92, timestamp: Date.now - TimeInterval(1225)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -34.9992, longitude: 174.8289), speed: 14.5, altitude: 24.47, timestamp: Date.now - TimeInterval(752)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.2727, longitude: 175.1124), speed: 8.02, altitude: 65.32, timestamp: Date.now - TimeInterval(243)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.8723, longitude: 175.1424), speed: 15.31, altitude: 72.11, timestamp: Date.now),
            ]
        ),
        Route(
            name: "Sample Route 2",
            routePoints: [
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -36.8509, longitude: 174.7645), speed: 0, altitude: 20, timestamp: Date.now - TimeInterval(1855)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.3725, longitude: 174.1116), speed: 23.4, altitude: 18.3, timestamp: Date.now - TimeInterval(1641)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.1729, longitude: 174.4692), speed: 29.22, altitude: 3.92, timestamp: Date.now - TimeInterval(1225)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -34.9992, longitude: 174.8289), speed: 14.5, altitude: 24.47, timestamp: Date.now - TimeInterval(752)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.2727, longitude: 175.1124), speed: 8.02, altitude: 65.32, timestamp: Date.now - TimeInterval(243)),
                RoutePoint(coordinate: CLLocationCoordinate2D(latitude: -35.8723, longitude: 175.1424), speed: 15.31, altitude: 72.11, timestamp: Date.now),
            ]
        )
    ]
}
