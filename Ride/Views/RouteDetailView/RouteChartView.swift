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
        Chart() {
            ForEach(0..<routePoints.count, id: \.self) {
                LineMark(
                    x: .value("km", routePoints.distanceBetween(i2: $0) / 1000),
                    y: .value("m", routePoints[$0].altitude))
            }
        }
        .chartXAxisLabel("km")
        .chartYAxisLabel("m")
    }
}

#Preview {
    RouteChartView(routePoints: Route.sampleRoute.points)
}
