//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import Combine

class SearchViewModel: ObservableObject {
    @Published var searchResults: [GameTitle] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: AlertMessage?
    
    private let networkService = NetworkService()
    private var searchText: String = ""
    
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
                    errorMessage = AlertMessage(message: "検索中エラーが発生しました。\n\(error)")
                }
            }
        }
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
