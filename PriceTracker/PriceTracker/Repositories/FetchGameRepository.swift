//
//  FetchGameRepository.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/03.
//

import Foundation

class FetchGameRepository {
  private let networkService = NetworkService()
  
  func fetchGame() async throws -> [SearchGameList] {
    return try await networkService.fetchGameAPI()
  }
}
