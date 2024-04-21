//
//  LocationManager.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import MapKit
import SwiftUI
import OSLog

@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {
    var region = MapCameraPosition.region(
        MKCoordinateRegion(
            center: .init(latitude: -36.8509, longitude: 174.7645),
            span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    )
    
    var routePoints: [RoutePoint] = []
    
    private let locationManger = CLLocationManager()
    
    private let log = Logger()
    
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
//            locationManger.startUpdatingLocation()
//            locationManger.startUpdatingHeading()
            log.info("Location authorization status authorized when in use.")
        case .notDetermined:
            locationManger.startUpdatingLocation()
            locationManger.requestWhenInUseAuthorization()
            log.notice("Location authorization status not determined.")
        default:
            break
        }
    }
    
    func startUpdatingLocation() {
        switch locationManger.authorizationStatus {
        case .authorizedWhenInUse:
            locationManger.startUpdatingLocation()
            locationManger.startUpdatingHeading()
            log.info("Starting updating location and heading.")
        case .notDetermined:
            setup()
        default:
            break
        }
    }
    
    func stopUpdatingLocation() {
        locationManger.stopUpdatingLocation()
        locationManger.stopUpdatingHeading()
        log.info("Stopping updating location and heading.")
    }
}

extension LocationManager {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManger.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        log.error("LocationManager error: \(error)")
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
        
        log.debug("[\(lastLocation.coordinate.latitude), \(lastLocation.coordinate.longitude)] \(lastLocation.speed.asKmH) km/h. Alt: \(lastLocation.altitude) m.")
        
        routePoints.append(RoutePoint(coordinate: lastLocation.coordinate, speed: lastLocation.speed, altitude: lastLocation.altitude, timestamp: lastLocation.timestamp))
    }
}
