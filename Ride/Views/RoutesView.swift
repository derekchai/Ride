//
//  RoutesView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import CoreLocation
import MapKit

struct RoutesView: View {
    @Binding var routes: [Route]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    List($routes) { $route in
                        Section (header: Text(route.points.endTimestamp?.formatted() ?? "No date")) {
                            Map {
                                // TODO: - Show route
                            }
                                .listRowInsets(EdgeInsets())
                                .frame(height: 200)
                                .allowsHitTesting(false)
                            
                            
                            NavigationLink(destination: RouteDetailView(route: route)) {
                                    RouteCardView(route: route)
                            }
                        }
                    }
                    .navigationTitle("Routes")
                }
            }
        } // NavigationStack
    }
}

#Preview {
    RoutesView(routes: .constant(Route.sampleData))
}
