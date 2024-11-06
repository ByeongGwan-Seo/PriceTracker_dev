//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import SwiftUI

protocol SearchViewModelProtocol {
    var searchText: String { get set }
    var isLoading: Bool { get set }
    var searchResults: [SearchGameList] { get set }
    func search()
    func fetchGameList()
}

class SearchViewModel: SearchViewModelProtocol, ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [SearchGameList] = []
    @Published var isLoading: Bool = false
    
    private let networkService: NetworkServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol = NetworkService()
    ) {
        self.networkService = networkService
    }
    
    func search() {
//        fetchGameList()
    }
    
    func fetchGameList() {
//        isLoading = true
//        Task {
//            do {
//                searchResults = try await networkService.fetchGameList(title: searchText)
//                searchText.removeAll()
//            } catch {
//                print("fetching gamelist error: \(error)")
//            }
//            isLoading = false
//        }
    }
}
