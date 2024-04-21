//
//  StatisticsSection.swift
//  Ride
//
//  Created by Derek Chai on 21/04/2024.
//

import SwiftUI

struct StatisticsSection: View {
    let route: Route
    
    var body: some View {
        Section(header: Text("Statistics")) {
            SpecificStatView(title: "Max. speed", value: "60.3 km/h", systemImage: "hare.fill")
            SpecificStatView(title: "Max. elevation", value: "160 m", systemImage: "arrowtriangle.up.fill")
            SpecificStatView(title: "Min. elevation", value: "0 m", systemImage: "arrowtriangle.down.fill")
            
            SpecificStatView(title: "Start", value: route.points.startTimestamp!.formatted(), systemImage: "hourglass.bottomhalf.filled")
            SpecificStatView(title: "End", value: route.points.endTimestamp!.formatted(), systemImage: "hourglass.tophalf.filled")
        }
    }
}

#Preview {
    StatisticsSection(route: Route.sampleRoute)
}
