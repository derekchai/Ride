//
//  RouteDetailView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import Charts
import MapKit

struct RouteDetailView: View {
    let route: Route
    
    @State private var showingSpeedColors: Bool = true
    
    var body: some View {
        List {
            Section(header: Text("Overview")) {
                RouteMapView(showingSpeedColors: $showingSpeedColors, points: route.routePoints)
                    .frame(height: 300)
                    .listRowInsets(EdgeInsets())
                
                Toggle("Show speed colors", isOn: $showingSpeedColors)
                
                HStack {
                    if let endTimestamp = route.routePoints.endTimestamp {
                        Text("Completed on \(endTimestamp.formatted())")
                            .font(.caption)
                            .padding([.bottom])
                    }
                    Spacer()
                }
                
                
                RouteStatisticsView(route: route)
            }
            
            Section(header: Text("Elevation Profile")) {
                RouteChartView(routePoints: route.routePoints)
                    .padding([.top, .bottom])
                    .frame(height: 250)
            }
            
            Section(header: Text("Statistics")) {
                RouteSpecificStatisticView(title: "Max. speed", value: "60.3 km/h", systemImage: "hare")
                RouteSpecificStatisticView(title: "Max. elevation", value: "160 m", systemImage: "arrowtriangle.up")
                RouteSpecificStatisticView(title: "Min. elevation", value: "0 m", systemImage: "arrowtriangle.down")
                
            }
        } // List
        .navigationTitle(route.name)
    }
}

#Preview {
    RouteDetailView(route: Route.sampleRoute)
}
