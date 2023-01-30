//
//  TrackingModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/24.
//

import Foundation

//모델 두개를 만들어서 서버에서 가져오는 거랑 앱에서만 쓰는거

struct TrackingInfo: Codable {
    let uuidString: String
    let title: String // from detailModel Info title
    let price: String // from detailModel Deal price
    let retailPrice: String
    let userPrice: String? // from detailModel Deal userPrice
    let gameID: String? // from searchGameList gameID
    let thumb: String // from detailModel Info thumb
    
}
