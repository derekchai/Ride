//
//  ElevationProfileSection.swift
//  Ride
//
//  Created by Derek Chai on 21/04/2024.
//

import SwiftUI

struct ElevationProfileSection: View {
    let route: Route
    
    @State private var selectedIndex: Int? = 0
    @State private var showingElevationChartHistogram: Bool = false
    
    var body: some View {
        Section(header: Text("Elevation Profile")) {
            if selectedIndex != nil {
                Text("\(String($selectedIndex.wrappedValue!))")
            } else {
                Text("")
            }
            ElevationChart(routePoints: route.points, showingHistogram: $showingElevationChartHistogram, selectedIndex: $selectedIndex)
                .padding([.top, .bottom])
                .frame(height: 250)
        }
    }
}

#Preview {
    ElevationProfileSection(route: Route.sampleRoute)
}
