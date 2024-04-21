//
//  RouteStatisticsView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI

struct RouteDetailStats: View {
    let points: [RoutePoint]
    
    var body: some View {
        VStack (alignment: .center) {
            Text(points.totalDistance.asRoundedKmOrM())
                .font(.title)
                .padding([.top, .bottom])
            
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "stopwatch")
                        Text(points.duration.asHMorMS)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("\(String(format: "%.1f", points.averageSpeed)) km/h")
                        Image(systemName: "figure.outdoor.cycle")
                    }
                }
                .padding([.bottom])
                
                HStack {
                    HStack {
                        Image(systemName: "arrow.up.forward")
                        Text("\(String(format: "%.0f", points.totalAltitudeGain)) m")
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("\(String(format: "%.0f", points.totalAltitudeLoss)) m")
                        Image(systemName: "arrow.down.forward")
                    }
                }
            }
        }
    }
}

#Preview {
    RouteDetailStats(points: Route.sampleRoute.points)
}
