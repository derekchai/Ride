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
    @Binding var routes: [Route]
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    List(searchResults) { result in
                        Section (header: Text(result.points.endTimestamp?.formatted() ?? "No date")) {
                            Map {
                                // TODO: - Show route preview
                            }
                                .listRowInsets(EdgeInsets())
                                .frame(height: 200)
                                .allowsHitTesting(false)
                            
                            
                            NavigationLink(destination: RouteDetailView(route: result)) {
                                    RouteStatsInListView(route: result)
                            }
                        }
                    }
                    .navigationTitle("Routes")
                }
            }
        } // NavigationStack
        .searchable(text: $searchText, prompt: "Search routes")
    } // body
    
    private var searchResults: [Route] {
        if searchText.isEmpty {
            return routes
        } else {
            return routes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    RoutesView(routes: .constant(Route.sampleData))
}
