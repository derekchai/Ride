//
//  SpeedometerView.swift
//  Ride
//
//  Created by Derek Chai on 16/04/2024.
//

import SwiftUI

struct SpeedometerView: View {
    /// Speed in metres per second.
    @Binding var speed: Double
    
    private let maxSpeedKmH: Double = 30.0
    
    private var speedKmH: Double {
        speed.asKmH
    }
    
    private var progressBarFillPercentage: Double {
        if speedKmH < 0 { return 0.0 }
        else if speedKmH > maxSpeedKmH { return 1.0 }
        else { return speedKmH / maxSpeedKmH }
    }
    
    private var speedGreaterThanMax: Bool {
        speedKmH > maxSpeedKmH
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .lastTextBaseline) {
                Text("0")
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(String(format: "%.0f", speedKmH))
                    .font(.bigNumber)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(String(format: "%.0f", maxSpeedKmH))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding([.leading, .trailing])
            
            SpeedometerBar(progress: .constant(progressBarFillPercentage))
                .padding([.leading, .trailing])

            
//            ProgressView(value: progressBarFillPercentage)
//                .progressViewStyle(SpeedometerProgressViewStyle(
//                    color: speedGreaterThanMax ? .orange : .blue)
//                )
//                .shadow(
//                    color: .orange, radius: speedGreaterThanMax ? 8 : 0
//                )
//                .animation(.easeInOut.speed(3), value: speedGreaterThanMax)
        }
        
        Text("km/h")
    }
}

#Preview {
    SpeedometerView(speed: .constant(25 / 3.6))
}
