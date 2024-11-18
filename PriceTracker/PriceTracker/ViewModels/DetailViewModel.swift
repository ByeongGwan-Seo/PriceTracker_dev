//
//  DetailViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI
import WebKit

struct WebViewForDetailView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

class DetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var gameDetail: DetailModel?
    @Published var errorMessage: AlertMessage?

    private let networkService: NetworkServiceProtocol
    private let gameId: String
    
    init(
        networkService : NetworkServiceProtocol = NetworkService(),
        gameId: String
    ) {
        self.networkService = networkService
        self.gameId = gameId
    }
    
    func fetchDetail() {
        isLoading = true
        Task {
            do {
                let gameDetail = try await self.networkService.fetchGameDetail(gameId: gameId)
                await MainActor.run {
                    self.gameDetail = gameDetail
                    isLoading = false
                    errorMessage = nil
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = AlertMessage(message: "詳細情報ロード中エラーが発生しました。\n\(error)")
                }
            }
        }
    }
    
    func openURL(for dealID: String) {
        guard let url = URL(string: "https://www.cheapshark.com/redirect?dealID=\(dealID)") else { return }
        UIApplication.shared.open(url)
    }
    
    
}
