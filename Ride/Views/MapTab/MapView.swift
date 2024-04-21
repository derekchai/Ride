//
//  MapView.swift
//  Ride
//
//  Created by Derek Chai on 15/04/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(LocationManager.self) private var locationManager: LocationManager
    @Environment(RouteTimer.self) private var routeTimer: RouteTimer
    
    @State private var activityMode: ActivityMode = .cycle
    @State private var hasStartedTracking = false
    
    @State private var startDate: Date?
    @State private var endDate: Date?
    
    // MARK: - Bindings
    
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
    
    // MARK: - body
    
    var body: some View {
        VStack {
            Map(initialPosition: locationManager.region) {
                UserAnnotation()
                routeOutline
                routeLine
            }
            .mapControls {
                MapCompass()
                MapUserLocationButton()
            }
            
            if !locationManager.routePoints.isEmpty && hasStartedTracking {
                InActivityView(
                    speed: speed,
                    distanceTravelled: distanceTravelled,
                    timeElapsed: timeElapsed,
                    elevationGained: elevationGained,
                    stopButtonPressed: onStopButtonPressed
                )
                .padding(.top)
                .environment(routeTimer)
            } else {
                OutOfActivityView(
                    selectedActivityMode: $activityMode,
                    goButtonPressed: onGoButtonPressed
                )
                .padding(.top)
            }
        }
    } // body
    
    
    // MARK: - MapContent parameters
    
    /// A polyline showing the user's route taken when in tracking mode.
    /// This is the white border/outline for the line itself.
    private var routeOutline: some MapContent {
        MapPolyline(coordinates: locationManager.routePoints.map { $0.coordinate })
            .strokeStyle(style: .mapRouteOutline)
            .stroke(.white)
    }
    
    /// A polyline showing the user's route taken when in tracking mode.
    /// This is the actual (blue) line showing the path.
    private var routeLine: some MapContent {
        MapPolyline(coordinates: locationManager.routePoints.map { $0.coordinate })
            .strokeStyle(style: .mapRouteLine)
            .stroke(.blue)
    }
    
    // MARK: - Actions
    
    private func onStopButtonPressed() {
        withAnimation {
            locationManager.stopUpdatingLocation()
            hasStartedTracking = false
        }
    }
    
    private func onGoButtonPressed() {
        withAnimation {
            locationManager.startUpdatingLocation()
            hasStartedTracking = true
        }
    }
    
}

#Preview {
    MapView().environment(LocationManager()).environment(RouteTimer())
}
