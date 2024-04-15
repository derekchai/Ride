//
//  RouteLineStyles.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation
import MapKit
import SwiftUI

class RouteLineStyle {
    static let line = StrokeStyle(
        lineWidth: 8,
        lineCap: .round
    )
    
    static let outline = StrokeStyle(
        lineWidth: 12,
        lineCap: .round
    )
}
