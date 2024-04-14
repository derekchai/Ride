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
    
    var body: some View {
        Map {}
        
        VStack (alignment: .center) {
            Text(route.totalDistance.asRoundedKmOrM())
                .font(.title)
                .padding([.bottom])
            
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "stopwatch")
                        Text(route.duration.asHMorMS)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("\(String(format: "%.1f", route.averageSpeed)) km/h")
                        Image(systemName: "figure.outdoor.cycle")
                    }
                }
                .padding([.bottom])
                
                HStack {
                    HStack {
                        Image(systemName: "arrow.up.forward")
                        Text("\(String(format: "%.0f", route.totalAltitudeGain)) m")
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("\(String(format: "%.0f", route.totalAltitudeLoss)) m")
                        Image(systemName: "arrow.down.forward")
                    }
                }
            }
            
            RouteChartView(routePoints: route.routePoints)
            
            if let endTimestamp = route.endTimestamp {
                Text("Completed on \(endTimestamp.formatted())")
                    .font(.subheadline)
                    .padding([.bottom])
            }
        }
            .padding()
            .navigationTitle(route.name)
    }
}

#Preview {
    RouteDetailView(route: Route.sampleRoute)
}
