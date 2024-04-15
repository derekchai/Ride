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
        lineWidth: 8,
        lineCap: .round
    )
    
    static let mapRouteOutline = StrokeStyle(
        lineWidth: 12,
        lineCap: .round
    )
}
