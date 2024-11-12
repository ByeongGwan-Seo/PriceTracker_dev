//
//  NetworkClient.swift
//  PriceTracker
//
//  Created by jaeeun on 2024/11/02.
//

import Foundation

protocol NetworkClientProtocol {
  func get<T: Decodable>(url: URL) async throws -> T
  func post<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T
}

class NetworkClient: NetworkClientProtocol {
  func get<T: Decodable>(url: URL) async throws -> T {
    do {
      let (data, response) = try await URLSession.shared.data(from: url)
      
      if let apiResponse = response as? HTTPURLResponse, !(200...299).contains(apiResponse.statusCode) {
        print("http error: \(apiResponse.statusCode)")
        throw URLError(.badServerResponse)
      }
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
    } catch {
      print("error! \(error)")
      throw error
    }
    
  }
  
  func post<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let encoder = JSONEncoder()
    request.httpBody = try encoder.encode(body)
    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      
      if let apiResponse = response as? HTTPURLResponse, !(200...299).contains(apiResponse.statusCode) {
        print("http error: \(apiResponse.statusCode)")
        throw URLError(.badServerResponse)
      }
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
    } catch {
      print("error! \(error)")
      throw error
    }
    
  }
}
