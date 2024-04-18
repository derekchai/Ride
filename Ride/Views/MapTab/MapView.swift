//
//  MapView.swift
//  Ride
//
//  Created by Derek Chai on 15/04/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var activityMode: ActivityMode = .cycle
    @State private var hasStartedTracking = false
    
    private var speed: Binding<CLLocationSpeed> {
        guard let mostRecentPoint = locationManager.routePoints.last else { return .constant(0) }
        if mostRecentPoint.speed < 0 { return .constant(0) }
        return Binding(get: { mostRecentPoint.speed }, set: { _ in })
    }
    
    private var distanceTravelled: Binding<CLLocationDistance> {
        return Binding(get: { locationManager.routePoints.totalDistance }, set: { _ in })
    }
    
    private var timeElapsed: Binding<TimeInterval> {
        return Binding(get: { locationManager.routePoints.duration }, set: { _ in })
    }
    
    private var elevationGained: Binding<CLLocationDistance> {
        return Binding(get: { locationManager.routePoints.totalAltitudeGain }, set: { _ in })
    }
    
    var body: some View {
        VStack {
            Map(initialPosition: $locationManager.region.wrappedValue) {
                UserAnnotation()
                routeOutline
                routeLine
            }
            .mapControls {
                MapCompass()
                MapUserLocationButton()
            }
            .sheet(isPresented: .constant(false)) {
            }
            
            if !locationManager.routePoints.isEmpty && hasStartedTracking {
                InActivityView(
                    speed: speed,
                    distanceTravelled: distanceTravelled,
                    timeElapsed: timeElapsed,
                    elevationGained: elevationGained
                )
                .animation(.easeInOut, value: hasStartedTracking)
                
                Button("Stop") {
                    locationManager.stopUpdatingLocation()
                    hasStartedTracking = false
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
            } else {
                OutOfActivityView(
                    selectedActivityMode: $activityMode,
                    goButtonPressed: {
                        locationManager.startUpdatingLocation()
                        hasStartedTracking = true
                    }
                )
                .animation(.easeInOut, value: hasStartedTracking)
            }
        }
    } // body
    
    
    // MARK: - MapContent
    
    /// A polyline showing the user's route taken when in tracking mode.
    /// This is the white border/outline for the line itself.
    private var routeOutline: some MapContent {
        MapPolyline(coordinates: $locationManager.routePoints.map { $0.coordinate.wrappedValue })
            .strokeStyle(style: .mapRouteOutline)
            .stroke(.white)
    }
    
    /// A polyline showing the user's route taken when in tracking mode.
    /// This is the actual (blue) line showing the path.
    private var routeLine: some MapContent {
        MapPolyline(coordinates: $locationManager.routePoints.map { $0.coordinate.wrappedValue })
            .strokeStyle(style: .mapRouteLine)
            .stroke(.blue)
    }
}

#Preview {
    MapView().environmentObject(LocationManager())
}
