//
//  LocationManager.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import MapKit
import SwiftUI

struct RoutePoint {
    var coordinate: CLLocationCoordinate2D
    var speed: CLLocationSpeed
}

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManger = CLLocationManager()
    
    @Published var region = MapCameraPosition.region(
        MKCoordinateRegion(
            center: .init(latitude: -36.8509, longitude: 174.7645),
            span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    )
    
    @Published var routePoints: [RoutePoint] = []
    
    override init() {
        super.init()
        
        self.locationManger.delegate = self
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
        self.setup()
    }
    
    private func setup() {
        switch locationManger.authorizationStatus {
        case .authorizedWhenInUse:
//                locationManger.requestLocation()
            locationManger.startUpdatingLocation()
            locationManger.startUpdatingHeading()
        case .notDetermined:
            locationManger.startUpdatingLocation()
            locationManger.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

extension LocationManager {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManger.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: $0.coordinate,
                    span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
        }
        
        guard let lastLocation = locations.last else { return }
        
        print("Coordinate: \(lastLocation.coordinate.latitude), \(lastLocation.coordinate.longitude). Speed: \(lastLocation.speed * 3.6) km/h")
        
        routePoints.append(RoutePoint(coordinate: lastLocation.coordinate, speed: lastLocation.speed))
    }
}
