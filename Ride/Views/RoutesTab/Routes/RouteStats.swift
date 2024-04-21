//
//  RouteCardView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import MapKit

struct RouteStats: View {
    let route: Route
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(route.name)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
    
            HStack {
                VStack(alignment: .leading) {
                    Text("Distance")
                        .font(.caption)
                    Text("\(route.points.totalDistance.asRoundedKmOrM())")
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Alt. gain")
                        .font(.caption)
                    Text("\(Int(route.points.totalAltitudeGain)) m")
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Duration")
                        .font(.caption)
                    Text("\(route.points.duration.asHMorMS)")
                }
            }
            .padding([.top])
        } // VStack
        .padding()
    }
}

#Preview {
    RouteStats(route: Route.sampleRoute)
}
