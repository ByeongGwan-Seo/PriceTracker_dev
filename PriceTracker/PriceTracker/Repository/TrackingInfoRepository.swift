//
//  DataStorageRepository.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/12/12.
//

import Foundation
import SwiftUI

protocol TrackingInfoRepositoryProtocol {
    func saveTrackingInfos(_ trackingInfos: [TrackingInfo])
    func loadTrackingInfos() -> [TrackingInfo]?
}

class TrackingInfoRepository: TrackingInfoRepositoryProtocol {
    @AppStorage("trackingInfos") private var storedTrackingInfoData: Data?

    func saveTrackingInfos(_ trackingInfos: [TrackingInfo]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(trackingInfos)
            storedTrackingInfoData = data
        } catch {
            print("Failed to encode TrackingInfos: \(error)")
        }
    }

    func loadTrackingInfos() -> [TrackingInfo]? {
        guard let data = storedTrackingInfoData else { return nil }
        do {
            let decoder = JSONDecoder()
            let trackingInfos = try decoder.decode([TrackingInfo].self, from: data)
            return trackingInfos
        } catch {
            print("Failed to decode TrackingInfos: \(error)")
            return nil
        }
    }
}
