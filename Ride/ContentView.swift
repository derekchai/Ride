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
    @State private var routeTimer = RouteTimer()
    
    var body: some View {
        TabView {
            RoutesView(routes: .constant(Route.sampleData))
                .tabItem {
                    Label("Routes", systemImage: "point.topleft.down.to.point.bottomright.curvepath")
                }
            
            MapView()
                .environment(locationManager)
                .environment(routeTimer)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

#Preview {
    ContentView()
}
