//
//  DealsTextView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/21.
//

import SwiftUI

struct DealsTextView: View {
    private let item: Deal
    private var getFormattedSavings: (Deal) -> String
    private var getPrice: (Deal) -> String
    
    init(
        item: Deal,
        getFormattedSavings: @escaping (Deal) -> String,
        getPrice: @escaping (Deal) -> String
    ) {
        self.item = item
        self.getFormattedSavings = getFormattedSavings
        self.getPrice = getPrice
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(getPrice(item))
                .font(.body)
            Text(getFormattedSavings(item))
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}
