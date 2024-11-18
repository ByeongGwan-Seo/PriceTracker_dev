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
    @Published var gameDetail: DetailModel?
    @Published var errorMessage: AlertMessage?
    @Published var status: ScreenStatus = .loading
    
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
        status = .loading
        Task {
            do {
                let gameDetail = try await self.networkService.fetchGameDetail(gameId: gameId)
                status = .success
                await MainActor.run {
                    self.gameDetail = gameDetail
                    errorMessage = nil
                }
            } catch {
                await MainActor.run {
                    status = .error
                    errorMessage = AlertMessage(message: "詳細情報ロード中エラーが発生しました。\n\(error)")
                }
            }
        }
    }
}
