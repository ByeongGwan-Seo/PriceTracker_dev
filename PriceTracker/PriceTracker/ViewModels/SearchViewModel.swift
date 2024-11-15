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
    
    private let networkService = NetworkService()
    private var searchText: String = ""
    
    func fetchGameList() {
        isLoading = true
        // TODO: 「確か　Task 自体に @mainactorを追加すると await MainActor.run を使わなくても Mainにできてた気がします。」→concurrency勉強して確認すること
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
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
