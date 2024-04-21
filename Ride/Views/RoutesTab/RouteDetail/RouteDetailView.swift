//
//  RouteDetailView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import Charts
import MapKit

/// A `View` of an individual route's specific details.
///
/// This `View` shows the route's key statistics, an interactive map, elevation
/// profile, and more detailed statistics.
struct RouteDetailView: View {
    let route: Route
    
    
    var body: some View {
        List {
            OverviewSection(route: route)
            
            MapSection(route: route)
            
            ElevationProfileSection(route: route)
            
            StatisticsSection(route: route)
        } 
        .navigationTitle(route.name)
    }
}

#Preview {
    RouteDetailView(route: Route.sampleRoute)
}
