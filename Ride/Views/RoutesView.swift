//
//  RoutesView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import CoreLocation

struct RoutesView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    
                }
                .navigationTitle("Routes")
                
                HStack {
                    Button("Go", systemImage: "figure.outdoor.cycle") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
            } // VStack
        } // NavigationStack
    }
}

#Preview {
    RoutesView()
}
