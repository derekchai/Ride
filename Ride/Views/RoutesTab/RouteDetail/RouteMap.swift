//
//  RouteMapView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import MapKit

struct RouteMap: View {
    @Binding var showingSpeedColors: Bool
    @Binding var distance: CLLocationDistance
    
    let points: [RoutePoint]
    
    private var cursorIndex: Int {
        points.firstIndex(where: { $0 == points.pointBeforeDistance(distance: distance)})!
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map {
                routeOutline
                
                if points.count >= 2 {
                    startMarker
                    endMarker
                }
                
                cursor
                
                if !showingSpeedColors || points.maxSpeed == nil {
                    uncoloredRouteLine
                        .stroke(.blue)
                } else if let maxSpeed = points.maxSpeed {
                    ForEach(0..<points.count - 1, id: \.self) {
                        MapPolyline(coordinates: [points[$0].coordinate, points[$0 + 1].coordinate])
                            .strokeStyle(style: .mapRouteLine)
                            .stroke(speedColor(speed: points[$0].speed, maxSpeed: maxSpeed))
                    }
                }
            } // Map
            
            if showingSpeedColors {
                if let maxSpeed = points.maxSpeed {
                    RouteMapLegendView(maxSpeed: maxSpeed)
                        .scaleEffect(0.8)
                }
            }
        }
    }
    
    // MARK: - MapContent parameters
    
    private var routeOutline: some MapContent {
        MapPolyline(coordinates: points.map { $0.coordinate })
            .strokeStyle(style: .mapRouteOutline)
            .stroke(.white)
    }
    
    private var uncoloredRouteLine: some MapContent {
        MapPolyline(coordinates: points.map { $0.coordinate })
            .strokeStyle(style: .mapRouteLine)
    }
    
    private var cursor: some MapContent {
        Annotation("Cursor", coordinate: points[cursorIndex].coordinate) {
            Circle()
                .stroke(.black, lineWidth: 14)
                .stroke(.white, lineWidth: 8)
                .fill(.black)
                .frame(width: 6, height: 6)
        }
        .annotationTitles(.hidden)
    }
    
    private var startMarker: some MapContent {
        Marker("Start", coordinate: points.first!.coordinate)
            .tint(.green)
    }
    
    private var endMarker: some MapContent {
        Marker("End", coordinate: points.last!.coordinate)
            .tint(.red)
    }
    
    // MARK: - Functions
    
    private func speedColor(speed: CLLocationSpeed, maxSpeed: CLLocationSpeed) -> Color {
        let r = speed / maxSpeed
        
        if speed < maxSpeed * 0.2 {
            return .black
        } else if speed < maxSpeed * 0.4 {
            return .red
        } else if speed < maxSpeed * 0.6 {
            return .orange
        } else if speed < maxSpeed * 0.8 {
            return .yellow
        } else {
            return .green
        }
    }
}

#Preview {
    RouteMap(showingSpeedColors: .constant(true), distance: .constant(0), points: Route.sampleRoute.points)
}
