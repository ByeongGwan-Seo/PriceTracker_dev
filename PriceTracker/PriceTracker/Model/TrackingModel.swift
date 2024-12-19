//
//  TrackingModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/24.
//

import Foundation

struct TrackingInfo: Codable, Identifiable {
    let id: UUID
    let title: String
    let userPrice: String?
    let thumb: String
    
    init(title: String, userPrice: String?, thumb: String, id: UUID = UUID()) {
        self.id = id
        self.title = title
        self.userPrice = userPrice
        self.thumb = thumb
    }
}
