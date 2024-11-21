//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import Combine

class SearchViewModel: ObservableObject {
    @Published var searchResults: [GameTitle] = []
    @Published var errorMessage: ErrorMessage?
    @Published var status: SearchScreenStatus = .noContent
    
    private let networkService = NetworkService()
    private var searchText: String = ""
    
    func fetchGameList() {
        status = .loading
        Task {
            do {
                let gameList = try await self.networkService.fetchGameList(title: searchText)
                status = .success
                await MainActor.run {
                    self.searchResults = gameList
                }
            } catch {
                await MainActor.run {
                    status = .error
                    errorMessage = ErrorMessage(message: "検索中エラーが発生しました。\n\(error)")
                }
            }
        }
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
