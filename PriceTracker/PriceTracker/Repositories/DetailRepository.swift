//
//  DetailRepository.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/03.
//

import Foundation

class DetailRepository {
  private let networkService = NetworkService()
  
  func fetchDetail(gameId: String) async throws -> DetailModel {
    return try await networkService.fetchDetail(gameId: gameId)
  }
}
