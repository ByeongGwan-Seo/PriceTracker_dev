//
//  DetailModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/23.
//

import Foundation

struct DetailModel: Codable, Equatable {
    let info: Info
    let cheapestPriceEver: CheapestPriceEver
    let deals: [Deal]
}

struct CheapestPriceEver: Codable, Equatable {
    let price: String
    let date: Int
}

struct Deal: Codable, Equatable {
    let storeID: String
    let dealID: String
    let price: String
    let retailPrice: String
    let userPrice: String?
    let savings: String
}

struct Info: Codable, Equatable {
    let title: String
    let steamAppID: String?
    let thumb: String
}

