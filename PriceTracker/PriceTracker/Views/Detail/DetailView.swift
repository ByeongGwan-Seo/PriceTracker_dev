//
//  DetailView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI
import Combine

struct DetailView<ViewModel: DetailViewModelProtocol>: View {
    @ObservedObject var detailViewModel: ViewModel
    
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
                    items: sortedDeals
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
                title: Text(
                    "Error"
                ),
                message: Text(
                    errorMessage.message
                ),
                dismissButton: 
                        .default(
                            Text(
                                "OK"
                            )
                        )
            )
        }
    }
}

#Preview("Detailview success preview") {
    let mockViewModel = makeMockDetailViewModel()
    DetailView(detailViewModel: mockViewModel)
}
