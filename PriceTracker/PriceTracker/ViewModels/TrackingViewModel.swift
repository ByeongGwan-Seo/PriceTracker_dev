//
//  TrackingViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/12/02.
//

import SwiftUI

class TrackingViewModel: ObservableObject {
    @Published var isTracking: Bool = false
    @Published var testText: String = "hello"
}
