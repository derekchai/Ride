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
    
    var body: some View {
        VStack {
            Map(initialPosition: $locationManager.region.wrappedValue) {
                UserAnnotation()
                
                MapPolyline(coordinates: $locationManager.routePoints.map { $0.coordinate.wrappedValue })
                    .strokeStyle(style: .mapRouteOutline)
                    .stroke(.white)
                
                MapPolyline(coordinates: $locationManager.routePoints.map { $0.coordinate.wrappedValue })
                    .strokeStyle(style: .mapRouteLine)
                    .stroke(.blue)
            }
            .mapControls {
                MapCompass()
            }
            
//            MapControlsView(selectedActivityMode: $selectedActivityMode)
            CurrentStatsView(
                speed: $locationManager.routePoints.last?.speed ?? .constant(0),
                distanceTravelled: .constant(locationManager.routePoints.totalDistance),
                timeElapsed: .constant(locationManager.routePoints.duration),
                elevationGained: .constant(locationManager.routePoints.totalAltitudeGain)
            )
        }
    }
}

#Preview {
    MapView().environmentObject(LocationManager())
}
