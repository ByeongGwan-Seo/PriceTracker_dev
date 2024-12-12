//
//  TrackingViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/12/02.
//

import SwiftUI
import Combine

class TrackingViewModel: ObservableObject {
    @AppStorage("trackingInfos") private var savedTrackingInfosData: Data = Data()

    @Published var trackingInfos: [TrackingInfo] = []
    private var cancellables = Set<AnyCancellable>()
    private let trackingInfoService: TrackingInfoServiceProtocol
    
    init(trackingInfoService: TrackingInfoServiceProtocol = TrackingInfoService()) {
        self.trackingInfoService = trackingInfoService
        loadTrackingInfos()
    }

    func loadTrackingInfos() {
        guard let loadedInfos = trackingInfoService.loadTrackingInfos() else { return print("Failed to load trackingInfos")}
        trackingInfos = loadedInfos
    }
    
    private func saveTrackingInfos() {
        trackingInfoService.saveTrackingInfos(trackingInfos)
        loadTrackingInfos()
    }
    
    func deleteTrackingInfo(at indexSet: IndexSet) {
        trackingInfos.remove(atOffsets: indexSet)
        saveTrackingInfos()
    }
    

    func getUserPrice(for item: TrackingInfo) -> String {
        "User Price: $\(item.userPrice ?? "")"
    }
}
