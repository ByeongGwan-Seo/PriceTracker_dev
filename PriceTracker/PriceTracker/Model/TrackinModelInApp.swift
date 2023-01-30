//
//  TrackinModelInApp.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/27.
//

import Foundation

struct TrackingInfoInApp: Codable {
    let uuidString: String
    let title: String // from detailModel Info title
    let price: String // from detailModel Deal price
    let retailPrice: String
    let userPrice: String? // from detailModel Deal userPrice
    let gameID: String? // from searchGameList gameID
    let thumb: String // from detailModel Info thumb
    var isTracked: Bool = false
}
