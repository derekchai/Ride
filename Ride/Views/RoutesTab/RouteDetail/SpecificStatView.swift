//
//  RouteSpecificStatisticView.swift
//  Ride
//
//  Created by Derek Chai on 15/04/2024.
//

import SwiftUI

struct SpecificStatView: View {
    let title: String
    let value: String
    let systemImage: String?
    
    var body: some View {
        HStack {
            Label("", systemImage: systemImage ?? "")
            
            LabeledContent(title, value: value)
        }
    }
}

#Preview {
    SpecificStatView(title: "Test", value: "Test value", systemImage: "stopwatch")
}
