//
//  RoutesView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import CoreLocation
import MapKit

/// A `View` of a list of all routes that the user has recorded.
///
/// Each route is presented with its key stats, a preview of the route itself
/// on a map, and with the option to view specific details about the route
/// when the list item is tapped.
struct RoutesView: View {
    @Environment(LocationManager.self) private var locationManager: LocationManager
    
//    @Binding var routes: [Route]
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            if !locationManager.routePoints.isEmpty {
                List(filteredRoutes) { route in
                    RouteCard(route: route)
                        .navigationTitle("Routes")
                }
            } else {
                Text("No routes")
                    .navigationTitle("Routes")
            }
        }
        .searchable(text: $searchText, prompt: "Search routes")
    }
    
    // MARK: - Logic
    
    /// Routes whose names contain `searchText`.
    private var filteredRoutes: [Route] {
        guard !locationManager.routes.isEmpty else { return [Route]() }
        
        if searchText.isEmpty {
            return locationManager.routes
        } else {
            return locationManager.routes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    RoutesView()
        .environment(LocationManager())
}
