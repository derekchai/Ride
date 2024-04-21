//
//  MapSection.swift
//  Ride
//
//  Created by Derek Chai on 21/04/2024.
//

import SwiftUI

struct MapSection: View {
    let route: Route
    
    @State private var showingSpeedColors: Bool = true
    @State private var mapSliderValue: Double = 0
    
    var body: some View {
        Section(header: Text("Map")) {
            RouteMap(showingSpeedColors: $showingSpeedColors, distance: $mapSliderValue, points: route.points)
                .frame(height: 300)
                .listRowInsets(EdgeInsets())
            
            Toggle("Show speed colors", isOn: $showingSpeedColors)
            Slider(
                value: $mapSliderValue,
                in: 0...route.points.totalDistance
            )
        }
    }
}

#Preview {
    MapSection(route: Route.sampleRoute)
}
