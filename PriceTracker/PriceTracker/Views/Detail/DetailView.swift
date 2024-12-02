//
//  DetailView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI
import WebKit

struct DetailView: View {
    @ObservedObject var detailViewModel: DetailViewModel
    
    var body: some View {
        VStack {
            switch detailViewModel.status {
            case .loading:
                ProgressView()
            case .success(
                let detail,
                let sortedDeals
            ):
                BasicInfoView(
                    item: detail,
                    isTracking: detailViewModel.isTracking,
                    onTrackingButtonTapped: {
                        detailViewModel.onTrackingButtonTapped()
                    }
                )
                Divider()
                DealsListView(
                    items: sortedDeals,
                    getFormattedSavings: detailViewModel.getFormattedSavings,
                    getPrice: detailViewModel.getPrice
                )
            case .error:
                EmptyView()
            }
        }
        .onAppear(
            perform: detailViewModel.fetchDetail
        )
        .alert(
            item: $detailViewModel.errorMessage
        ) { errorMessage in
            Alert(
                title: Text("error_alert_title"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("alert_dismiss_ok"))
            )
        }
        .sheet(isPresented: $detailViewModel.showTrackingAlert) {
            VStack {
                Text("Enter Price")
                    .font(.headline)
                    .padding()

                TextField("Enter your target price", text: $detailViewModel.inputPrice)
                    .keyboardType(.decimalPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                HStack {
                    Button("Cancel") {
                        detailViewModel.showTrackingAlert = false
                    }
                    .padding()

                    Spacer()

                    Button("OK") {
                        if !detailViewModel.inputPrice.isEmpty {
                            detailViewModel.isTracking = true
                            detailViewModel.showTrackingAlert = false
                        }
                    }
                    .padding()
                }
                .padding()
            }
            .padding()
        }
    }
}
