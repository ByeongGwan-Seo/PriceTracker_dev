//
//  TrackingModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/24.
//

import Foundation

struct TrackingInfo: Codable {
    let uuidString: String
    let title: String
    let userPrice: String?
    let thumb: String
}
