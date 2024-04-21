//
//  RouteGraph.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import Charts
import CoreLocation

/// A chart of elevation against distance for a list of `RoutePoint`s.
struct ElevationChart: View {
    let routePoints: [RoutePoint]
    
    @Binding var showingHistogram: Bool
    @Binding var selectedIndex: Int?
    
    private var distancesAndAltitudes: [(CLLocationDistance, CLLocationDistance)] {
        Array(zip(routePoints.distances, routePoints.altitudes))
    }
    
    var body: some View {
        Chart() {
            ForEach((0..<distancesAndAltitudes.count), id: \.self) {i in
                LineMark(
                    x: .value("Distance (metres)", distancesAndAltitudes[i].0),
                    y: .value("Altitude (metres)", distancesAndAltitudes[i].1)
                )
//                .interpolationMethod(.catmullRom)
                if i < distancesAndAltitudes.count - 1 && showingHistogram {
                    LineMark(
                        x: .value("Distance (metres)", distancesAndAltitudes[i + 1].0),
                        y: .value("Altitude (metres)", distancesAndAltitudes[i].1)
                    )
                }
            }
            
            if let selectedIndex {
                RuleMark(x: .value("Index", selectedIndex))
                    .foregroundStyle(.gray)
            }
        }
        .chartXAxisLabel("m")
        .chartYAxisLabel("m")
        .chartXSelection(value: $selectedIndex)
      
    }
}

#Preview {
    ElevationChart(routePoints: Route.sampleRoute.points, showingHistogram: .constant(false), selectedIndex: .constant(0))
}
