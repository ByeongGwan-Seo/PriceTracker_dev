//
//  DealsListView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/21.
//

import SwiftUI

struct DealsListView: View {
    private let items: [Deal]
    private var getFormattedSavings: (Deal) -> String
    private var getPrice: (Deal) -> String

    init(
        items: [Deal],
        getFormattedSavings: @escaping (Deal) -> String,
        getPrice: @escaping (Deal) -> String
    ) {
        self.items = items
        self.getFormattedSavings = getFormattedSavings
        self.getPrice = getPrice
    }

    var body: some View {
        List(items, id: \.dealID) { deal in
            if let url = URL(string: "https://www.cheapshark.com/redirect?dealID=\(deal.dealID)") {
                NavigationLink(
                    destination: WebViewForDetailView(url: url)
                ) {
                    DealView(item: deal, getFormattedSavings: getFormattedSavings, getPrice: getPrice)
                }
            }
        }
        .listStyle(.plain)
    }
}
