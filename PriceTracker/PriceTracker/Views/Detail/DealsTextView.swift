//
//  DealsTextView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/21.
//

import SwiftUI

struct DealsTextView: View {
    private let item: Deal
    
    init(item: Deal) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Price: $\(item.price)")
                .font(.body)
            Text("Savings: " +
                 ((Double(item.savings) ?? 0.0) < 1.0
                  ? "None"
                  : "\(String(format: "%.2f", Double(item.savings) ?? 0.0))%"))
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}
