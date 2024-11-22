//
//  DetailViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI


class DetailViewModel: ObservableObject {
    @Published var contents: DetailModel?
    @Published var errorMessage: ErrorMessage?
    @Published var status: DetailScreenStatus = .loading
    
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
                let sortedDeals = gameDetail.deals.sorted {
                    Double($0.price) ?? 0 < Double($1.price) ?? 0
                }
                await MainActor.run {
                    status = .success(items: gameDetail, sortedDeals: sortedDeals)
                    self.contents = gameDetail
                    errorMessage = nil
                }
            } catch {
                await MainActor.run {
                    status = .error
                    errorMessage = ErrorMessage(message: "詳細情報ロード中エラーが発生しました。\n\(error)")
                }
            }
        }
    }
}
