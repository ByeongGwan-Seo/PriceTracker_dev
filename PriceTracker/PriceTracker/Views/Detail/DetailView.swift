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
                    item: detail
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
    }
}
