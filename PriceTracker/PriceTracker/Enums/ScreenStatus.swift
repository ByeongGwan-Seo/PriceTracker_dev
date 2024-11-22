//
//  ScreenStatus.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/18.
//

enum SearchScreenStatus {
    case loading
    case success(items: [GameTitle])
    case noContent
    case error
}

enum DetailScreenStatus {
    case loading
    case success(items: DetailModel, sortedDeals: [Deal])
    case error
}
