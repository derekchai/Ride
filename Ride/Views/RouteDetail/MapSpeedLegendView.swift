//
//  RouteMapLegendView.swift
//  Ride
//
//  Created by Derek Chai on 15/04/2024.
//

import SwiftUI

struct RouteMapLegendView: View {
    let maxSpeed: Double
    
    var body: some View {
        Grid(alignment: .trailing) {
            GridRow {
                Text("km/h")
                    .font(.caption)
                Text("")
            }
            GridRow {
                Text("> \(Int(maxSpeed * 0.8))")
                Image(systemName: "circle.fill")
                    .foregroundStyle(.green)
            }
            GridRow {
                Text("> \(Int(maxSpeed * 0.6))")
                Image(systemName: "circle.fill")
                    .foregroundStyle(.yellow)
            }
            GridRow {
                Text("> \(Int(maxSpeed * 0.4))")
                Image(systemName: "circle.fill")
                    .foregroundStyle(.orange)
            }
            GridRow {
                Text("> \(Int(maxSpeed * 0.2))")
                Image(systemName: "circle.fill")
                    .foregroundStyle(.red)
            }
            GridRow {
                Text("> 0")
                Image(systemName: "circle.fill")
                    .foregroundStyle(.black)
            }

        }
    }
}

#Preview {
    RouteMapLegendView(maxSpeed: 60)
}
