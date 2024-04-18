//
//  TimeIntervalExtension.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation

extension TimeInterval {
    
    /// Returns a formatted string in either `-h -m` or `-m -s` format.
    var asHMorMS: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 2
        formatter.zeroFormattingBehavior = .default
        
        return formatter.string(from: self)!
    }
    
    /// Returns a formatted string in `-:-:-` format.
    var asHMS: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        
        return formatter.string(from: self)!
    }
}
