//
//  TrackingViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/12/02.
//

import SwiftUI
import Combine

class TrackingViewModel: ObservableObject {
    @Published var trackingInfos: [TrackingInfo] = []
    private var cancellables = Set<AnyCancellable>()

    @MainActor
    func loadTrackingInfos() {
        Just(UserDefaults.standard.data(forKey: "trackingInfos"))
            .compactMap { $0 }
            .decode(type: [TrackingInfo].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { [weak self] decodedInfos in
                self?.trackingInfos = decodedInfos
            }
            .store(in: &cancellables)
    }

    func getUserPrice(for item: TrackingInfo) -> String {
        "User Price: $\(item.userPrice ?? "")"
    }
}
