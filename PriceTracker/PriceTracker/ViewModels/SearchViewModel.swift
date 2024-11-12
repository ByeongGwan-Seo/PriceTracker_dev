//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import SwiftUI
import Combine

protocol SearchViewModelProtocol {
    var searchText: String { get set }
    var isLoading: Bool { get set }
    var searchResults: [SearchGameList] { get set }
    func fetchGameList()
    func moveToDetail()
}

class SearchViewModel: SearchViewModelProtocol, ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [SearchGameList] = []
    @Published var isLoading: Bool = false
    
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        router: RouterProtocol
    ) {
        self.networkService = networkService
        self.router = router
    }
    
    func fetchGameList() {
        isLoading = true
        Task {
            do {
                let gameList = try await self.networkService.fetchGameList(title: self.searchText)
                await MainActor.run {
                    self.searchResults = gameList
                    isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
    
    func moveToDetail() {
        router.showDetail()
    }
}
