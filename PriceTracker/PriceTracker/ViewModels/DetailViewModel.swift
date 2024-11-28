//
//  DetailViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI


class DetailViewModel: ObservableObject {
    @Published var gameDetail: DetailModel?
    @Published var errorMessage: ErrorMessage?
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
                    let localizedMessage = String(format: NSLocalizedString("detail_error_message", comment: "error occurred while loading detail"), "\(error)")
                    errorMessage = ErrorMessage(message: localizedMessage)
                }
            }
        }
    }
}
