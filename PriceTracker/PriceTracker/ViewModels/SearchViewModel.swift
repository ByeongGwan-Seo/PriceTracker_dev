//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import SwiftUI
import Combine

protocol SearchViewModelProtocol {
    func search()
    func fetchGameList()
}
class SearchViewModel: ObservableObject, SearchViewModelProtocol {
    @Published var searchText: String = ""
    @Published var searchResults: [SearchGameList] = []
    @Published var isLoading: Bool = false
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func search() {
        fetchGameList()
    }
    
    internal func fetchGameList() {
        isLoading = true
        Task {
            do {
                searchResults = try await networkService.fetchGameList(title: searchText)
                searchText.removeAll()
            } catch {
                print("fetching gamelist error: \(error)")
            }
            isLoading = false
        }
    }
}
