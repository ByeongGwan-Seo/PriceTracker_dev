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
                    updateSearchSucessStatus(gameList: gameList)
                }
            } catch {
                await MainActor.run {
                    updateErrorStatus(error: error)
                }
            }
        }
    }

    @MainActor
    private func updateErrorStatus(error: Error) {
        let localizedMessage = String(format:
                                        NSLocalizedString("search_error_message",
                                    comment: "error occurred while loading search results"), "\(error)")
        errorMessage = ErrorMessage(message: localizedMessage)
    }

    @MainActor
    private func updateSearchSucessStatus(gameList: [GameTitle]) {
        status = gameList.isEmpty ? .noContent : .success(items: gameList)
        self.contents = gameList
        errorMessage = nil
    }

    func setSearchText(text: String) {
        self.searchText = text
    }
}
