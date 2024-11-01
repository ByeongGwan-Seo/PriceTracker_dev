//
//  NetworkService.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/19.
//

import UIKit
import Foundation

class NetworkService {
  var title = ""
  var id = ""
  
  func fetchGameAPI() async throws -> [SearchGameList] {
    let urlString = "https://www.cheapshark.com/api/1.0/games?"
    
    guard var urlComponents = URLComponents(string: urlString) else {
      throw URLError(.badURL)
    }
    urlComponents.queryItems = [
      URLQueryItem(name: "title", value: title)
    ]
    
    guard let url = urlComponents.url else {
      throw URLError(.badURL)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let decoder = JSONDecoder()
    let result = try decoder.decode([SearchGameList].self, from: data)
    return result
  }
  
  func fetchDetail(gameId: String) async throws -> DetailModel {
    let urlString = "https://www.cheapshark.com/api/1.0/games?"
    
    guard var urlComponents = URLComponents(string: urlString) else {
      throw URLError(.badURL)
    }
    
    urlComponents.queryItems = [
      URLQueryItem(name: "id", value: gameId)
    ]
    
    guard let url = urlComponents.url else {
      throw URLError(.badURL)
    }
    
    print("url is here: \(url)")
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let decoder = JSONDecoder()
    let result = try decoder.decode(DetailModel.self, from: data)
    print("result is here: \(result)")
    return result
  }
}


