//
//  NetworkService.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/19.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchGameList(title: String) async throws -> [GameTitle]
    func fetchGameDetail(gameId: String) async throws -> DetailModel
}

class NetworkService: NetworkServiceProtocol {
    private let gameRepository: GameRepositoryProtocol

    init(
        gameRepository: GameRepositoryProtocol = GameRepository()
    ) {
        self.gameRepository = gameRepository
    }

    func fetchGameList(title: String) async throws -> [GameTitle] {
        return try await gameRepository.fetchGames(title: title)
    }

    func fetchGameDetail(gameId: String) async throws -> DetailModel {
        return try await gameRepository.fetchDetail(gameId: gameId)
    }
}
