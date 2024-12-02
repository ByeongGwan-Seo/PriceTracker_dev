//
//  TrackingViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/12/02.
//

import SwiftUI

class TrackingViewModel: ObservableObject {
    @Published var showAlert = false
       @Published var inputPrice = ""
       @Published var isTracking = false
       
       func updateTrackingStatus() {
           guard !inputPrice.isEmpty else { return }
           isTracking = true
       }
}
