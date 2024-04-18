//
//  StrokeStyleExtension.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import MapKit
import SwiftUI

extension StrokeStyle {
    
    /// Style for a polyline on a map to track user location.
    static let mapRouteLine = StrokeStyle(
        lineWidth: 4,
        lineCap: .round,
        lineJoin: .round
    )
    
    /// Style for the outline of a polyline on a map to track user location.
    ///
    /// This line should be subimposed beneath the actual line itself.
    static let mapRouteOutline = StrokeStyle(
        lineWidth: 6,
        lineCap: .round,
        lineJoin: .round
    )
    
    static let routePreview = StrokeStyle(
        lineWidth: 5,
        lineCap: .round,
        lineJoin: .round
    )
}
