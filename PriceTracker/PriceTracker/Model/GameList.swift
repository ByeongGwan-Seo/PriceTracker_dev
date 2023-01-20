//
//  GameList.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/19.
//

import Foundation

struct GameList: Codable {
    let gameID: String?
    let steamAppID: String?
    let cheapest: String?
    let cheapestDealID: String?
    let external: String?
    let thumb: String?
}
