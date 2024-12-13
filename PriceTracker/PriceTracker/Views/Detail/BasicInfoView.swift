//
//  BasicInfoView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/21.
//

import SwiftUI

struct BasicInfoView: View {
    private let item: DetailModel
    private let isTracking: Bool
    private let onTrackingButtonTapped: () -> Void

    init(item: DetailModel, isTracking: Bool, onTrackingButtonTapped: @escaping () -> Void) {
        self.item = item
        self.isTracking = isTracking
        self.onTrackingButtonTapped = onTrackingButtonTapped
    }

    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 10) {
                AsyncImage(url: URL(string: item.info.thumb)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 100)

                Button(action: onTrackingButtonTapped) {
                    Text(isTracking ? LocalizedStringKey("already_tracking_string") : LocalizedStringKey("add_tracking_string"))
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 150)
                            .background(isTracking ? Color.red : Color.blue)
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
                Text(String(format: NSLocalizedString("retail_price_string", comment: ""),
                            item.deals.first?.retailPrice ?? ""))
                Text(String(format: NSLocalizedString("cheapest_ever_string", comment: ""),
                            item.cheapestPriceEver.price))
            }
            Spacer()
        }
    }
}
