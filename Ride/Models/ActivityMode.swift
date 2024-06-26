//
//  ActivityMode.swift
//  Ride
//
//  Created by Derek Chai on 18/04/2024.
//

import Foundation

enum ActivityMode: String, CaseIterable, Identifiable {
    case cycle, walk
    var id: Self { self }
}
