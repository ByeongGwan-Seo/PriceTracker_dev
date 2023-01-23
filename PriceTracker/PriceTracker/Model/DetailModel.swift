//
//  DetailModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/23.
//

import Foundation

struct DetailModel: Codable {
    let info: Info
    let cheapestPriceEver: CheapestPriceEver
    let deals: [Deal]
}

struct CheapestPriceEver: Codable {
    let price: String
    let date: Int
}

struct Deal: Codable {
    let storeID, dealID, price, retailPrice: String
    let userPrice: String?
    let savings: String
}

// MARK: - Info
struct Info: Codable {
    let title: String
    let steamAppID: String?
    let thumb: String
}
