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
            if detailViewModel.isLoading {
                ProgressView()
            } else if let detail = detailViewModel.gameDetail {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: detail.info.thumb)) { image in
                        image.resizable().frame(width: 150, height: 100)
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(detail.info.title)
                            .font(.title2)
                            .lineLimit(4)
                        Text("Retail Price: $\(detail.deals.first?.retailPrice ?? "")")
                        Text("Cheapest Ever: $\(detail.cheapestPriceEver.price)")
                    }
                    Spacer()
                }
                Divider()
                List(detailViewModel.gameDetail?.deals.sorted(by: {
                    Double($0.price) ?? 0 < Double($1.price) ?? 0
                }) ?? [], id: \.dealID) { deal in
                    NavigationLink(
                        destination: WebView(url: URL(string: "https://www.cheapshark.com/redirect?dealID=\(deal.dealID)")!)
                    ) {
                        HStack {
                            // Store logo
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
                        .contentShape(Rectangle())  // 탭 가능 영역 확장
                        .background(Color(UIColor.systemBackground)) // 배경 색상
                        .cornerRadius(10) // 모서리 둥글게
                    }
                }
                .listStyle(.plain)
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



