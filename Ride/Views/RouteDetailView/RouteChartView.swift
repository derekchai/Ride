//
//  RouteGraph.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import Charts

struct RouteChartView: View {
    let routePoints: [RoutePoint]
    
    var body: some View {
        Chart(routePoints) { point in
            LineMark(
                x: .value("", point.timestamp),
                y: .value("", point.speed)
            )
        }
    }
}

#Preview {
    RouteChartView(routePoints: Route.sampleRoute.routePoints)
}
