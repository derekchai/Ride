//
//  RouteCard.swift
//  Ride
//
//  Created by Derek Chai on 21/04/2024.
//

import SwiftUI
import MapKit

/// A section showing a route's name, key stats, and a preview of the route on
/// a map.
struct RouteCard: View {
    let route: Route
    
    var body: some View {
        Section (header: Text(route.points.endTimestamp?.formatted() ?? "No date")) {
            Map {
                // TODO: - Show route preview
            }
            .listRowInsets(EdgeInsets())
            .frame(height: 200)
            .allowsHitTesting(false)
            
            NavigationLink(destination: RouteDetailView(route: route)) {
                RouteStats(route: route)
            }
        }
    }
}

#Preview {
    RouteCard(route: Route.sampleRoute)
}
