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
    
    func getFormattedSavings(for item: Deal) -> String {
        let savings = item.doubledString(string: item.savings)
        let savingsText: String
        
        if savings < 1.0 {
            savingsText = L10n.savingsNoneString
        } else {
            savingsText = L10n.savingsString(String(format: "%.2f", savings))
        }
        
        return savingsText
    }
    
    func getPrice(for item: Deal) -> String {
        L10n.priceString(item.price)
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
                    errorMessage = ErrorMessage(message: L10n.detailErrorMessage(error))
                }
            }
        }
    }
}
