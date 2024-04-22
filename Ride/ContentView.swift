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
    @State private var locationManager = LocationManager()
    
    var body: some View {
        TabView {
            RoutesView()
                .tabItem {
                    Label("Routes", systemImage: "point.topleft.down.to.point.bottomright.curvepath")
                }
                .environment(locationManager)
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .environment(locationManager)
        }
    }
}

#Preview {
    ContentView()
}
