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
            ThumbnailView(
                urlString: item.thumnailImageUrl()
            )
            DealsTextView(
                item: item
            )
            .padding(
                .vertical,
                5
            )
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
