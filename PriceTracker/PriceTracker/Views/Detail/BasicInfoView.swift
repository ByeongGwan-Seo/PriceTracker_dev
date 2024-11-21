//
//  BasicInfoView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/21.
//

import SwiftUI

struct BasicInfoView: View {
    private let item: DetailModel
    
    init(item: DetailModel) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            Spacer()
            AsyncImage(url: URL(string: item.info.thumb)) { image in
                image.resizable().frame(width: 150, height: 100)
            } placeholder: {
                ProgressView()
            }
            Spacer()
            VStack(alignment: .leading) {
                Text(item.info.title)
                    .font(.title2)
                    .lineLimit(4)
                Text("Retail Price: $\(item.deals.first?.retailPrice ?? "")")
                Text("Cheapest Ever: $\(item.cheapestPriceEver.price)")
            }
            Spacer()
        }
    }
}
