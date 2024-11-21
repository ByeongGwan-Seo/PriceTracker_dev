//
//  DealsListView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/21.
//

import SwiftUI

struct DealsListView: View {
    private let items: [Deal]
    
    init(items: [Deal]) {
        self.items = items
    }
    
    var body: some View {
        List(items, id: \.dealID) { deal in
            if let url = URL(string: "https://www.cheapshark.com/redirect?dealID=\(deal.dealID)") {
                NavigationLink(
                    destination: WebViewForDetailView(url: url)
                ) {
                    DealView(item: deal)
                }
            }
        }
        .listStyle(.plain)
    }
}
