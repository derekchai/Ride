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
    
    @State private var selectedActivityMode: ActivityMode = .cycle
    @State private var hasStartedTracking = false
    
    var body: some View {
        VStack {
            Map(initialPosition: $locationManager.region.wrappedValue) {
                UserAnnotation()
                routeOutline
                routeLine
            }
            .mapControls {
                MapCompass()
            }
            
            if !locationManager.routePoints.isEmpty && hasStartedTracking {
                // MARK: - Current stats view
                
                InActivityView(
                    speed: $locationManager.routePoints.last?.speed ?? .constant(0),
                    distanceTravelled: .constant(locationManager.routePoints.totalDistance),
                    timeElapsed: .constant(locationManager.routePoints.duration),
                    elevationGained: .constant(locationManager.routePoints.totalAltitudeGain)
                )
                .animation(.easeInOut, value: hasStartedTracking)
                
                Button("Stop") {
                    locationManager.stopUpdatingLocation()
                    hasStartedTracking = false
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
            } else {
                // MARK: - Controls view
                
                OutOfActivityView(
                    selectedActivityMode: $selectedActivityMode,
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
