//
//  TrackingView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/12/02.
//

import SwiftUI

struct TrackingView: View {
    @ObservedObject var trackingViewModel: TrackingViewModel
    var body: some View {
        VStack {
            Text("Tracking Information:")
                .font(.headline)

            List(trackingViewModel.trackingInfos) { trackingInfo in
                VStack(alignment: .leading) {
                    Text("\(trackingInfo.title)")
                    Text(trackingViewModel.getUserPrice(for: trackingInfo))
                }
                .swipeActions {
                    Button(role: .destructive) {
                        trackingViewModel.deleteTrackingInfo(trackingInfo)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .listStyle(.plain)
            .onAppear {
                trackingViewModel.loadTrackingInfos()
            }
            .refreshable {
                trackingViewModel.loadTrackingInfos()
            }
        }
        .padding()
    }
}
