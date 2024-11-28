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
            case .success:
                if let detail = detailViewModel.gameDetail {
                    DetailBasicInfoView(detailContents: detail)
                    Divider()
                    DetailDealsListView(detailContents: detail)
                }
            case .noContent:
                NoContentView()
            case .error:
                EmptyView()
            }
        }
        .onAppear(perform: detailViewModel.fetchDetail)
        .alert(item: $detailViewModel.errorMessage) { errorMessage in
            Alert(
                title: Text("error_alert_title"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("alert_dismiss_ok"))
            )
        }
    }
}

fileprivate struct DetailBasicInfoView: View {
    private let detailContents: DetailModel
    
    init(detailContents: DetailModel) {
        self.detailContents = detailContents
    }
    
    var body: some View {
        HStack {
            Spacer()
            AsyncImage(url: URL(string: detailContents.info.thumb)) { image in
                image.resizable().frame(width: 150, height: 100)
            } placeholder: {
                ProgressView()
            }
            Spacer()
            VStack(alignment: .leading) {
                Text(detailContents.info.title)
                    .font(.title2)
                    .lineLimit(4)
                Text(String(format: NSLocalizedString("retail_price_string", comment: ""), detailContents.deals.first?.retailPrice ?? ""))
                Text(String(format: NSLocalizedString("cheapest_ever_string", comment: ""), detailContents.cheapestPriceEver.price))
            }
            Spacer()
        }
    }
}

fileprivate struct DetailDealsListView: View {
    private let detailContents: DetailModel
    
    init(detailContents: DetailModel) {
        self.detailContents = detailContents
    }
    
    var body: some View {
        List(detailContents.deals.sorted(by: {
            Double($0.price) ?? 0 < Double($1.price) ?? 0
        }), id: \.dealID) { deal in
            if let url = URL(string: "https://www.cheapshark.com/redirect?dealID=\(deal.dealID)") {
                NavigationLink(
                    destination: WebViewForDetailView(url: url)
                ) {
                    DealsListViewCell(deal: deal)
                }
            }
        }
        .listStyle(.plain)
    }
}

fileprivate struct DealsListViewCell: View {
    private let deal: Deal
    
    init (deal: Deal) {
        self.deal = deal
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text("Price: $\(deal.price)")
                    .font(.body)
                Text("Savings: " +
                     ((Double(deal.savings) ?? 0.0) < 1.0
                            ? "None"
                      : "\(String(format: "%.2f", Double(deal.savings) ?? 0.0))%"))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 5)
        }
        .contentShape(Rectangle())
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
    }
}


