//
//  DealView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/21.
//

import SwiftUI

struct DealView: View {
    private let item: Deal
    private var getFormattedSavings: (Deal) -> String
    private var getPrice: (Deal) -> String

    init (
        item: Deal,
        getFormattedSavings: @escaping (Deal) -> String,
        getPrice: @escaping (Deal) -> String
    ) {
        self.item = item
        self.getFormattedSavings = getFormattedSavings
        self.getPrice = getPrice
    }

    var body: some View {
        HStack {
            ThumbnailView(
                urlString: item.thumnailImageUrl()
            )
            DealsTextView(
                item: item, getFormattedSavings: getFormattedSavings, getPrice: getPrice
            )
            .padding(.vertical, 5)
        }
        .contentShape(
            Rectangle()
        )
        .background(
            Color(
                UIColor.systemBackground
            )
        )
        .cornerRadius(
            10
        )
    }
}
