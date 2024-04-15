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
    static let mapRouteLine = StrokeStyle(
        lineWidth: 4,
        lineCap: .round,
        lineJoin: .round
    )
    
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
