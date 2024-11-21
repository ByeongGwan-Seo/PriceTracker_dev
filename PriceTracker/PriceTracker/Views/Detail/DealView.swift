//
//  DealView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/21.
//

import SwiftUI

struct DealView: View {
    private let item: Deal
    
    init (item: Deal) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            ThumbnailView(urlString: "https://www.cheapshark.com/img/stores/logos/\((Int(item.storeID) ?? 0) - 1).png")
            DealsTextView(item: item)
                .padding(.vertical, 5)
        }
        .contentShape(Rectangle())
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
    }
}
