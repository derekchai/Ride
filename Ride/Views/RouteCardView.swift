//
//  RouteCardView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI

struct RouteCardView: View {
    let route: Route
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(route.name)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            if let finishTimestamp = route.startTimestamp {
                Text(finishTimestamp.formatted(date: .complete, time: .shortened))
                    .font(.caption)
            }
    
            HStack {
                VStack(alignment: .leading) {
                    Text("Distance")
                        .font(.caption)
                    Text("\(route.totalDistance.asRoundedKmOrM())")
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Alt. gain")
                        .font(.caption)
                    Text("\(Int(route.totalAltitudeGain)) m")
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Duration")
                        .font(.caption)
                    Text("\(route.duration.asHMorMS)")
                }
            }
            .padding([.top])
        } // VStack
        .padding()
    }
}

#Preview {
    RouteCardView(route: Route.sampleRoute)
}
