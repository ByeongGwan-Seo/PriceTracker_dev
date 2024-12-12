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

    @MainActor
    func loadTrackingInfos() {
        Just(UserDefaults.standard.data(forKey: "trackingInfos"))
            .compactMap { $0 }
            .decode(type: [TrackingInfo].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to decode trackingInfos: \(error)")
                }
            }, receiveValue: { [weak self] decodedInfos in
                self?.trackingInfos = decodedInfos
            })
            .store(in: &cancellables)
    }
    
    func deleteTrackingInfo(at indexSet: IndexSet) {
        trackingInfos.remove(atOffsets: indexSet)
        saveTrackingInfos()
    }
    
    private func saveTrackingInfos() {
        if let encodedData = try? JSONEncoder().encode(trackingInfos) {
            savedTrackingInfosData = encodedData
        }
    }

    func getUserPrice(for item: TrackingInfo) -> String {
        "User Price: $\(item.userPrice ?? "")"
    }
}
