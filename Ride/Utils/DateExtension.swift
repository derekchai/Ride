//
//  DateExtension.swift
//  Ride
//
//  Created by Derek Chai on 14/04/2024.
//

import Foundation

extension Date {
    
    /// Returns the difference between two `Date`s as a `TimeInterval`.
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
