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
            VStack(spacing: 10) {
                AsyncImage(url: URL(string: item.info.thumb)) { image in
                    image
                        .resizable()
                        .frame(width: 150, height: 100)
                } placeholder: {
                    ProgressView()
                }
                
                Button(action: {
                    print("Add Tracking 버튼이 눌렸습니다.")
                }) {
                    Text("Add Tracking")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
            VStack(alignment: .leading) {
                Text(item.info.title)
                    .font(.title2)
                    .lineLimit(4)
                Spacer()
                    .frame(height: 20)
                Text("Retail Price: $\(item.deals.first?.retailPrice ?? "")")
                Text("Cheapest Ever: $\(item.cheapestPriceEver.price)")
            }
            Spacer()
        }
    }
}
