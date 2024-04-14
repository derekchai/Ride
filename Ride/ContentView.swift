//
//  ContentView.swift
//  Ride
//
//  Created by Derek Chai on 13/04/2024.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    @StateObject var manager = LocationManager()
    
    private let routeLineStyle = StrokeStyle(
        lineWidth: 8,
        lineCap: .round
    )
    
    private let routeOutlineStyle = StrokeStyle(
        lineWidth: 12,
        lineCap: .round
    )
    
    var body: some View {
        VStack {
            Map(position: $manager.region) {
                UserAnnotation()
                MapPolyline(coordinates: $manager.routeCoordinates.wrappedValue)
                    .strokeStyle(style: routeOutlineStyle)
                    .stroke(.white)
                
                MapPolyline(coordinates: $manager.routeCoordinates.wrappedValue)
                    .strokeStyle(style: routeLineStyle)
                    .stroke(.blue)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
