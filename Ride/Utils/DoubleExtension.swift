//
//  DoubleExtension.swift
//  Ride
//
//  Created by Derek Chai on 16/04/2024.
//

import Foundation

extension Double {
    
    /// Returns a `string` rounded to the specified number of decimal places.
    func roundedString(dp: Int = 0) -> String {
        return String(format: "%.\(dp)f", self)
    }
}
