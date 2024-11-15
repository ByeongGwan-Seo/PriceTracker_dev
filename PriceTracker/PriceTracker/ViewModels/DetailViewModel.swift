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
    
    init(
        networkService : NetworkServiceProtocol = NetworkService()
    ) {
        self.networkService = networkService
    }
    
    func fetchDetail(gameId: String) {
        isLoading = true
        Task {
            do {
                let gameDetail = try await self.networkService.fetchGameDetail(gameId: gameId)
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
