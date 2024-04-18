//
//  Speedometer.swift
//  Ride
//
//  Created by Derek Chai on 16/04/2024.
//

import SwiftUI

struct SpeedometerBar: View {
    @Binding var progress: CGFloat
    
    private let barHeight = 12.0
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: barHeight / 2)
                    .frame(width: geo.size.width, height: barHeight)
                    .opacity(0.3)
                    .foregroundStyle(.gray)
                
                RoundedRectangle(cornerRadius: barHeight / 2)
                    .frame(width: progress * geo.size.width, height: barHeight)
                    .foregroundStyle(.blue)
                    .animation(.easeInOut, value: progress)
                
            }
        }
        .frame(height: barHeight)
    }
}

#Preview {
    SpeedometerBar(progress: .constant(0.2))
}
