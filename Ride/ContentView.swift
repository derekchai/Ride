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
    @StateObject var locationManager = LocationManager()
    
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
            Map(initialPosition: $locationManager.region.wrappedValue) {
                UserAnnotation()
                
                MapPolyline(coordinates: $locationManager.routePoints.map { $0.coordinate.wrappedValue })
                    .strokeStyle(style: routeOutlineStyle)
                    .stroke(.white)
                
                MapPolyline(coordinates: $locationManager.routePoints.map { $0.coordinate.wrappedValue })
                    .strokeStyle(style: routeLineStyle)
                    .stroke(.blue)
            }
            .mapControls {
                MapCompass()
            }
        }
    }
}

#Preview {
    ContentView()
}
