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
    
    @State private var activityMode: ActivityMode = .cycle
    @State private var hasStartedTracking = false
    
    @State private var startDate: Date?
    @State private var endDate: Date?
    @State private var timerSecondsElapsed: TimeInterval = 0
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
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
                    stopButtonPressed: {
                        withAnimation {
                            locationManager.stopUpdatingLocation()
                            hasStartedTracking = false
                        }
                    }
                )
                .padding(.top)
                .environment(routeTimer)
            } else {
                OutOfActivityView(
                    selectedActivityMode: $activityMode,
                    goButtonPressed: {
                        withAnimation {
                            locationManager.startUpdatingLocation()
                            hasStartedTracking = true
                        }
                    }
                )
                .padding(.top)
            }
        }
        
        HStack {
            Text("\(timerSecondsElapsed.roundedString(dp: 2)) s")
                .onReceive(timer) { _ in
                    if let startDate {
                        timerSecondsElapsed += 0.01
                    }
                }
            
            Button("Start") {
                startDate = Date.now
            }
            
            Button("Stop") {
                endDate = Date.now
                startDate = nil
            }
        }
    } // body
    
    
    // MARK: - MapContent variables
    
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
}

#Preview {
    MapView().environment(LocationManager())
}
