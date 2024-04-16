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
    @State private var showingElevationChartHistogram: Bool = false
    @State private var selectedIndex: Int? = 0
//    @State private var mapIndex: Int = 0
    
    @State private var mapSliderValue: Double = 0
    
    
    
    
    var body: some View {
        List {
            // MARK: - Overview
            Section(header: Text("Overview")) {
                RouteStatisticsView(route: route)
                
                if let endTimestamp = route.points.endTimestamp {
                    Text("Completed on \(endTimestamp.formatted())")
                        .font(.caption)
                        .padding([.bottom])
                }
            }
            
            // MARK: - Map
            Section(header: Text("Map")) {
                RouteMapView(showingSpeedColors: $showingSpeedColors, distance: $mapSliderValue, points: route.points)
                    .frame(height: 300)
                    .listRowInsets(EdgeInsets())
                
                Toggle("Show speed colors", isOn: $showingSpeedColors)
                Slider(
                    value: $mapSliderValue,
                    in: 0...route.points.totalDistance
                
                )
            }
            
            // MARK: - Elevation Profile
            Section(header: Text("Elevation Profile")) {
                if selectedIndex != nil {
                    Text("\(String($selectedIndex.wrappedValue!))")
                } else {
                    Text("")
                }
                RouteChartView(routePoints: route.points, showingHistogram: $showingElevationChartHistogram, selectedIndex: $selectedIndex)
                    .padding([.top, .bottom])
                    .frame(height: 250)
                
            }
            
            // MARK: - Statistics
            Section(header: Text("Statistics")) {
                RouteSpecificStatisticView(title: "Max. speed", value: "60.3 km/h", systemImage: "hare.fill")
                RouteSpecificStatisticView(title: "Max. elevation", value: "160 m", systemImage: "arrowtriangle.up.fill")
                RouteSpecificStatisticView(title: "Min. elevation", value: "0 m", systemImage: "arrowtriangle.down.fill")
                
                RouteSpecificStatisticView(title: "Start", value: route.points.startTimestamp!.formatted(), systemImage: "hourglass.bottomhalf.filled")
                RouteSpecificStatisticView(title: "End", value: route.points.endTimestamp!.formatted(), systemImage: "hourglass.tophalf.filled")
                
            }
        } // List
        .navigationTitle(route.name)
    }
}

#Preview {
    RouteDetailView(route: Route.sampleRoute)
}
