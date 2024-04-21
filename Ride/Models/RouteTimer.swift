//
//  RouteTimer.swift
//  Ride
//
//  Created by Derek Chai on 21/04/2024.
//

import Foundation

@Observable
class RouteTimer {
    var secondsElapsed = 0.00
    
    private var timer: Timer?
    private var hasStarted = false
    private var frequency: TimeInterval { 0.01 }
  
    func start() {
        hasStarted = true
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { _ in
            self.update()
        }
    }
    
    private func update() {
        secondsElapsed += 0.01
    }
}
