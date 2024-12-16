//
//  GameRepository.swift
//  PriceTracker
//
//  Created by jaeeun on 2024/11/02.
//

import Foundation

protocol GameRepositoryProtocol {
    func fetchGames(title: String) async throws -> [GameTitle]
    func fetchDetail(gameId: String) async throws -> DetailModel
}

class GameRepository: GameRepositoryProtocol {
    private let networkClient: NetworkClientProtocol
    private let baseURL = URL(string: NSLocalizedString("base_URL", comment: ""))!

    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }

    func fetchGames(title: String) async throws -> [GameTitle] {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent("/games"), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "title", value: title)
        ]

        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }

        return try await networkClient.get(url: url)
    }

    func fetchDetail(gameId: String) async throws -> DetailModel {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent("/games"), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "id", value: gameId)
        ]

        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }

        return try await networkClient.get(url: url)
    }
}
