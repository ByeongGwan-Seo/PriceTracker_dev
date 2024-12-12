//
//  TrackingInfoService.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/12/12.
//

import Foundation

protocol TrackingInfoServiceProtocol {
    func saveTrackingInfos(_ trackingInfos: [TrackingInfo])
    func loadTrackingInfos() -> [TrackingInfo]?
}

class TrackingInfoService: TrackingInfoServiceProtocol {
    private let trackingInfoRepository: TrackingInfoRepositoryProtocol

    init(
        trackingInfoRepository: TrackingInfoRepositoryProtocol = TrackingInfoRepository()
    ) {
        self.trackingInfoRepository = trackingInfoRepository
    }

    func saveTrackingInfos(_ trackingInfos: [TrackingInfo]) {
        trackingInfoRepository.saveTrackingInfos(trackingInfos)
    }

    func loadTrackingInfos() -> [TrackingInfo]? {
        return trackingInfoRepository.loadTrackingInfos()
    }
}
