//
//  MapDuringActivityView.swift
//  Ride
//
//  Created by Derek Chai on 16/04/2024.
//

import SwiftUI
import CoreLocation

struct InActivityView: View {
    @Binding var speed: CLLocationSpeed
    @Binding var distanceTravelled: CLLocationDistance
    @Binding var timeElapsed: TimeInterval
    @Binding var elevationGained: CLLocationDistance
    
    var body: some View {
            VStack(alignment: .center) {
                SpeedometerView(speed: $speed)
                    
                HStack {
                    VStack {
                        Text("\(distanceTravelled.asKm.roundedString(dp: 2)) km")
                            .font(.title)
                            .padding(.top)
                        Text("traveled")
                    }
                    .frame(maxWidth: .infinity)
                    VStack {
                        Text("\(timeElapsed.asHMS)")
                            .font(.title)
                            .padding(.top)
                        Text("elapsed")
                    }
                    .frame(maxWidth: .infinity)
                    VStack {
                        Text("\(elevationGained.roundedString()) m")
                            .font(.title)
                            .padding(.top)
                        Text("climbed")
                    }
                    .frame(maxWidth: .infinity)
                }
            }
    }
}

#Preview {
    InActivityView(
        speed: .constant(17.2),
        distanceTravelled: .constant(32152),
        timeElapsed: .constant(TimeInterval(5020)),
        elevationGained: .constant(30)
    )
}
