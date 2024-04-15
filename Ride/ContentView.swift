//
//  ContentView.swift
//  Ride
//
//  Created by Derek Chai on 13/04/2024.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
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
        }
    }
}

#Preview {
    ContentView()
}
