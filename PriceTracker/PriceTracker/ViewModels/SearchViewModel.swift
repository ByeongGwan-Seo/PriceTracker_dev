//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    @Published var contents: [GameTitle] = []
    @Published var status: SearchScreenStatus = .noContent
    @Published var errorMessage: ErrorMessage?
    
    private let networkService = NetworkService()
    private var searchText: String = ""
    
    func fetchGameList() {
        status = .loading
        Task {
            do {
                let gameList = try await self.networkService.fetchGameList(title: searchText)
                await MainActor.run {
                    status = gameList.isEmpty ? .noContent : .success(items: gameList)
                    self.contents = gameList
                }
            } catch {
                await MainActor.run {
                    status = .error
                    errorMessage = ErrorMessage(message: L10n.searchErrorMessage(error))
                }
            }
        }
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
