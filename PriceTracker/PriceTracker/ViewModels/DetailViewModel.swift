//
//  DetailViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI

protocol DetailViewModelProtocol {
    var isLoading: Bool { get set }
    func fetchDetail()
}

class DetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
//    var gameId: String = ""
    
    private let networkService: NetworkServiceProtocol
    
    init(
//        gameId: String,
        networkService : NetworkServiceProtocol = NetworkService()
    ) {
//        self.gameeId = gameId
        self.networkService = networkService
    }
    
    func fetchDetail(gameId: String) {
        isLoading = true
        Task {
            do {
                let gameDetail = try await self.networkService.fetchGameDetail(gameId: gameId)
            }
        }
    }
}
