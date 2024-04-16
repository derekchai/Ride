//
//  ProgressViewStyles.swift
//  Ride
//
//  Created by Derek Chai on 16/04/2024.
//

import Foundation
import SwiftUI

struct SpeedometerProgressViewStyle: ProgressViewStyle {
  var color: Color

  func makeBody(configuration: Configuration) -> some View {
      ProgressView(configuration)
          .accentColor(color)
          .frame(height: 8.0) // Manipulate height, y scale effect and corner radius to achieve your needed results
          .scaleEffect(x: 1, y: 2, anchor: .center)
          .clipShape(RoundedRectangle(cornerRadius: 6))
          .padding(.horizontal)
          .animation(.easeInOut)
  }
}
