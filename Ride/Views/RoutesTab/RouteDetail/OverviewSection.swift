//
//  OverviewSection.swift
//  Ride
//
//  Created by Derek Chai on 21/04/2024.
//

import SwiftUI

struct OverviewSection: View {
    let route: Route
    
    var body: some View {
        Section(header: Text("Overview")) {
            RouteDetailStats(points: route.points)
            
            if let endTimestamp = route.points.endTimestamp {
                Text("Completed on \(endTimestamp.formatted())")
                    .font(.caption)
                    .padding([.bottom])
            }
        }
    }
}

#Preview {
    OverviewSection(route: Route.sampleRoute)
}
