//
//  MapControlsView.swift
//  Ride
//
//  Created by Derek Chai on 16/04/2024.
//

import SwiftUI

struct MapControlsView: View {
    @Binding var selectedActivityMode: ActivityMode
    
    var body: some View {
        Picker("Activity Mode", selection: $selectedActivityMode) {
            ForEach(ActivityMode.allCases) { mode in
                mode == .cycle ? Image(systemName: "figure.outdoor.cycle")
                : Image(systemName: "figure.walk")
            }
        }
        .pickerStyle(.segmented)
        .padding([.leading, .trailing])
        
        Button("Go") {
            
        }
        .buttonStyle(.borderedProminent)
        .padding(.bottom)
    }
}

#Preview {
    MapControlsView(selectedActivityMode: .constant(.cycle))
}
