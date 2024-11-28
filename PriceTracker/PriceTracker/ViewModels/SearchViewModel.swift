//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import Combine
import Foundation

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
                    let localizedMessage = String(format: NSLocalizedString("search_error_message", comment: "Error message shown when search fails"), "\(error)")
                    errorMessage = ErrorMessage(message: localizedMessage)
                }
            }
        }
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
