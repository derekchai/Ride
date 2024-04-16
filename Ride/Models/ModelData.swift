//
//  ModelData.swift
//  Ride
//
//  Created by Derek Chai on 16/04/2024.
//

import Foundation
import CoreLocation

@Observable
class ModelData {
    var routes: [Route] = Route.sampleData
    
    var currentCoordinates: CLLocationCoordinate2D?
    var currentSpeed: CLLocationSpeed?
    var currentAltitude: CLLocationDistance?
}
