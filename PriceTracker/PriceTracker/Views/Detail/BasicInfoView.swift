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
                        .frame(width: 150, height: 100)
                } placeholder: {
                    ProgressView()
                }
                
                Button(action: onTrackingButtonTapped) {
                    Text(isTracking ? "Tracking Now" : "Add Tracking")
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
                Text("Retail Price: $\(item.deals.first?.retailPrice ?? "")")
                Text("Cheapest Ever: $\(item.cheapestPriceEver.price)")
            }
            Spacer()
        }
    }
}
