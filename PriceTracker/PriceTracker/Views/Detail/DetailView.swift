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
        .overlay(
            detailViewModel.showTrackingAlert ? detailTrackingOverlay : nil
        )
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
            title: Text(L10n.errorAlertTitle),
            message: Text(errorMessage.message),
            dismissButton: .default(Text(L10n.okButton))
        )
    }

    private var detailTrackingOverlay: some View {
        DetailTrackingOverlayView(
            inputPrice: $detailViewModel.inputPrice,
            onCancel: detailViewModel.onPriceInputCancelled,
            onOK: detailViewModel.onPriceInputConfirmed
        )
    }
}
