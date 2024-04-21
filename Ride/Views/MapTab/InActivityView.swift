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
    
    var stopButtonPressed: () -> ()
    
    var body: some View {
        VStack(alignment: .center) {
            SpeedometerView(speed: $speed)
                
            HStack(alignment: .bottom) {
                VStack {
                    Text("\(distanceTravelled.asKm.roundedString(dp: 2)) km")
                        .font(.title2)
                        .padding(.top)
                    Text("traveled")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity)
                
                Button("Stop") {
                    stopButtonPressed()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("\(timeElapsed.asHMS)")
                        .font(.title2)
                        .padding(.top)
                    Text("elapsed")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity)
                
//                VStack {
//                    Text("\(elevationGained.roundedString()) m")
//                        .font(.headline)
//                        .padding(.top)
//                    Text("climbed")
//                        .font(.subheadline)
//                }
//                .frame(maxWidth: .infinity)
            }
            .padding(.bottom)
            
//            Button("Stop") {
//                stopButtonPressed()
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(.red)
        } // VStack
    }
}

#Preview {
    InActivityView(
        speed: .constant(17.2),
        distanceTravelled: .constant(32152),
        timeElapsed: .constant(TimeInterval(5020)),
        elevationGained: .constant(30),
        stopButtonPressed: {}
    )
}
