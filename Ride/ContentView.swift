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
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        TabView {
            RoutesView(routes: .constant(Route.sampleData))
                .tabItem {
                    Label("Routes", systemImage: "point.topleft.down.to.point.bottomright.curvepath")
                }
            
            MapView()
                .environmentObject(locationManager)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

#Preview {
    ContentView()
}
