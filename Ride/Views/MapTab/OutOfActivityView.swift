//
//  MapControlsView.swift
//  Ride
//
//  Created by Derek Chai on 16/04/2024.
//

import SwiftUI

struct OutOfActivityView: View {
    @Binding var selectedActivityMode: ActivityMode
    
    @State private var test: String = ""
    
    var goButtonPressed: () -> ()
    
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
            self.goButtonPressed()
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
        .padding(.bottom)
    }
}

#Preview {
    OutOfActivityView(selectedActivityMode: .constant(.cycle), goButtonPressed: {})
}
