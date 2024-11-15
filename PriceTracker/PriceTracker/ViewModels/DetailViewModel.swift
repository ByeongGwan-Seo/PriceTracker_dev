//
//  DetailViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var gameDetail: DetailModel?

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
                let gameDetail = try await self.networkService.fetchGameDetail(gameId: self.gameId)
                await MainActor.run {
                    self.gameDetail = gameDetail
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
}
