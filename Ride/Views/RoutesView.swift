//
//  RoutesView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import CoreLocation

struct RoutesView: View {
    @Binding var routes: [Route]
    
    var body: some View {
        NavigationStack {
            VStack {
                List($routes) { $route in
                    NavigationLink(destination: RouteDetailView(route: route)) {
                        RouteCardView(route: route)
                    }
                }
                .navigationTitle("Routes")
                
                HStack {
                    Button("Go", systemImage: "figure.outdoor.cycle") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
            } // VStack
        } // NavigationStack
    }
}

#Preview {
    RoutesView(routes: .constant(Route.sampleData))
}
