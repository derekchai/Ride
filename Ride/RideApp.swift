//
//  RideApp.swift
//  Ride
//
//  Created by Derek Chai on 13/04/2024.
//

import SwiftUI
import SwiftData

@main
struct RideApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    Route.self
                ])
        }
    }
}
