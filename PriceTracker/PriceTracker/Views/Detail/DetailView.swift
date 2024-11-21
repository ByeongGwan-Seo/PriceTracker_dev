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
                    BasicInfoView(item: detail)
                    Divider()
                    DealsListView(item: detail)
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
                title: Text("Error"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

fileprivate struct BasicInfoView: View {
    private let item: DetailModel
    
    init(item: DetailModel) {
        self.item = item
    }
    
    
    // NG
    var body: some View {
        HStack {
            Spacer()
            AsyncImage(url: URL(string: item.info.thumb)) { image in
                image.resizable().frame(width: 150, height: 100)
            } placeholder: {
                ProgressView()
            }
            Spacer()
            VStack(alignment: .leading) {
                Text(item.info.title)
                    .font(.title2)
                    .lineLimit(4)
                Text("Retail Price: $\(item.deals.first?.retailPrice ?? "")")
                Text("Cheapest Ever: $\(item.cheapestPriceEver.price)")
            }
            Spacer()
        }
    }
}

fileprivate struct DealsListView: View {
    private let item: DetailModel
    
    init(item: DetailModel) {
        self.item = item
    }
    
    var body: some View {
        // NG 뷰에 비지니스로직은 피해라
        List(item.deals.sorted(by: {
            Double($0.price) ?? 0 < Double($1.price) ?? 0
        }), id: \.dealID) { deal in
            if let url = URL(string: "https://www.cheapshark.com/redirect?dealID=\(deal.dealID)") {
                NavigationLink(
                    destination: WebViewForDetailView(url: url)
                ) {
                    DealsView(item: deal)
                }
            }
        }
        .listStyle(.plain)
    }
}

fileprivate struct DealsView: View {
    private let item: Deal
    
    init (item: Deal) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            ThumnailView(urlString: "")
            DealsTextView(item: item)
            .padding(.vertical, 5)
        }
        .contentShape(Rectangle())
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
    }
}

fileprivate struct ThumnailView: View {
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .frame(width: 100, height: 100)
        } placeholder: {
            ProgressView()
        }
    }
}

private struct DealsTextView: View {
    private let item: Deal
    
    init(item: Deal) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Price: $\(item.price)")
                .font(.body)
            Text("Savings: " +
                 ((Double(item.savings) ?? 0.0) < 1.0
                        ? "None"
                  : "\(String(format: "%.2f", Double(item.savings) ?? 0.0))%"))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
