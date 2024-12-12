//
//  DetailView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var detailViewModel: DetailViewModel

    var body: some View {
        VStack {
            switch detailViewModel.status {
            case .loading:
                loadingView
            case .success(let detail, let sortedDeals):
                successView(detail: detail, sortedDeals: sortedDeals)
            case .error:
                errorView
            }
        }
        .padding()
        .onAppear(
            perform: detailViewModel.fetchDetail
        )
        .alert(item: $detailViewModel.errorMessage) { errorMessage in
            errorAlert(errorMessage: errorMessage)
        }
        .overlay(detailTrackingOverlay)
    }
}

extension DetailView {
    private var loadingView: some View {
        ProgressView()
    }

    private func successView(detail: DetailModel, sortedDeals: [Deal]) -> some View {
        VStack {
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
        }
    }

    private var errorView: some View {
        EmptyView()
    }

    private func errorAlert(errorMessage: ErrorMessage) -> Alert {
        Alert(
            title: Text("error_alert_title"),
            message: Text(errorMessage.message),
            dismissButton: .default(Text("alert_dismiss_ok"))
        )
    }

    private var detailTrackingOverlay: some View {
        DetailTrackingOverlayView(
            showTrackingAlert: $detailViewModel.showTrackingAlert,
            inputPrice: $detailViewModel.inputPrice,
            onCancel: detailViewModel.onPriceInputCancelled,
            onOK: detailViewModel.onPriceInputConfirmed
        )
    }
}
