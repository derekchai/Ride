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
    
    @State private var hasStopped = false
    
    var stopButtonPressed: () -> ()
    var goButtonPressed: () -> ()
    
    var body: some View {
        VStack(alignment: .center) {
            SpeedometerView(speed: $speed)
                
            HStack(alignment: .bottom) {
                distanceTravelledView
                
                if hasStopped {
                    goButton
                } else {
                    stopButton
                }
                
                timeElapsedView
                
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
        } // VStack
    }
    
    // MARK: - View parameters
    
    private var distanceTravelledView: some View {
        VStack {
            Text("\(distanceTravelled.asKm.roundedString(dp: 2)) km")
                .font(.title2)
                .padding(.top)
            Text("traveled")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var timeElapsedView: some View {
        VStack {
            Text("\(timeElapsed.asHMS)")
                .font(.title2)
                .padding(.top)
            Text("elapsed")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var goButton: some View {
        Button("Go") {
            goButtonPressed()
            
            hasStopped = false
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
        .frame(maxWidth: .infinity)
    }
    
    private var stopButton: some View {
        Button("Stop") {
            stopButtonPressed()
            hasStopped = true
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Actions
    
    
    
}

#Preview {
    InActivityView(
        speed: .constant(17.2),
        distanceTravelled: .constant(32152),
        timeElapsed: .constant(TimeInterval(5020)),
        elevationGained: .constant(30),
        stopButtonPressed: {}, goButtonPressed: {}
    )
}
