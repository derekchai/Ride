//
//  RoutesView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import CoreLocation
import MapKit
import SwiftData

/// A `View` of a list of all routes that the user has recorded.
///
/// Each route is presented with its key stats, a preview of the route itself
/// on a map, and with the option to view specific details about the route
/// when the list item is tapped.
struct RoutesView: View {
    @Environment(LocationManager.self) private var locationManager: LocationManager
    @Query var allRoutes: [Route]
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            if !allRoutes.isEmpty {
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
        guard !allRoutes.isEmpty else { return [Route]() }
        
        if searchText.isEmpty {
            return allRoutes
                .sorted { $0.endTimestamp > $1.endTimestamp }
        } else {
            return allRoutes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                .sorted { $0.endTimestamp.timeIntervalSinceReferenceDate > $1.endTimestamp.timeIntervalSinceReferenceDate }
        }
    }
}

#Preview {
    RoutesView()
        .environment(LocationManager())
}
