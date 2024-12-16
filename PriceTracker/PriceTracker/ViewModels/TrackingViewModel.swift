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
        let result = trackingInfoService.loadTrackingInfos()

        switch result {
        case .success(let loadedInfos):
            trackingInfos = loadedInfos
        case .failure:
            print("Failed to load trackingInfos")
        }
    }

    private func saveTrackingInfos() {
        trackingInfoService.saveTrackingInfos(trackingInfos)
        loadTrackingInfos()
    }

    func deleteTrackingInfo(_ trackingInfo: TrackingInfo) {
        if let index = trackingInfos.firstIndex(where: { $0.id == trackingInfo.id }) {
            trackingInfos.remove(at: index)
            saveTrackingInfos()
        }
    }

    func getUserPrice(for item: TrackingInfo) -> String {
        String(format: NSLocalizedString("user_price_string", comment: ""), item.userPrice ?? "")
    }
}
