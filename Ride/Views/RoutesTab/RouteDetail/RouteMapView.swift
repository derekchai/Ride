//
//  RouteMapView.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import SwiftUI
import MapKit

struct RouteMapView: View {
    @Binding var showingSpeedColors: Bool
    @Binding var distance: CLLocationDistance
    
    let points: [RoutePoint]
    
    private var cursorIndex: Int {
        points.firstIndex(where: { $0 == points.pointBeforeDistance(distance: distance)})!
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map {
                MapPolyline(coordinates: points.map { $0.coordinate })
                    .strokeStyle(style: .mapRouteOutline)
                    .stroke(.white)
                
                if points.count >= 2 {
                    Marker("Start", coordinate: points.first!.coordinate)
                        .tint(.red)
                    
                    Marker("End", coordinate: points.last!.coordinate)
                        .tint(.green)
                }
                
                Annotation("Cursor", coordinate: points[cursorIndex].coordinate) {
                    Circle()
                        .stroke(.black, lineWidth: 14)
                        .stroke(.white, lineWidth: 8)
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                .annotationTitles(.hidden)
                
                
                if !showingSpeedColors || points.maxSpeed == nil {
                    MapPolyline(coordinates: points.map { $0.coordinate })
                        .strokeStyle(style: .mapRouteLine)
                        .stroke(.blue)
                } else if let maxSpeed = points.maxSpeed {
                    ForEach(0..<points.count - 1, id: \.self) {
                        let polyline = MapPolyline(coordinates: [points[$0].coordinate, points[$0 + 1].coordinate])
                            .strokeStyle(style: .mapRouteLine)
                        
                        let speed = points[$0].speed
                        
                        if speed < maxSpeed * 0.2 {
                            polyline.stroke(.black)
                        } else if speed < maxSpeed * 0.4 {
                            polyline.stroke(.red)
                        } else if speed < maxSpeed * 0.6 {
                            polyline.stroke(.orange)
                        } else if speed < maxSpeed * 0.8 {
                            polyline.stroke(.yellow)
                        } else {
                            polyline.stroke(.green)
                        }
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
}

#Preview {
    RouteMapView(showingSpeedColors: .constant(true), distance: .constant(0), points: Route.sampleRoute.points)
}
