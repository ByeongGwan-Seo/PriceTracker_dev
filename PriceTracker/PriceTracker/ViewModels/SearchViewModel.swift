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
    @Published var status: ScreenStatus = .noContent
    
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
                    errorMessage = ErrorMessage(message: L10n.searchError(error))
                }
            }
        }
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
