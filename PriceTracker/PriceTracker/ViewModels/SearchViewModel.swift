//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

//import SwiftUI
import Combine

protocol SearchViewModelProtocol {
    var isLoading: Bool { get set }
    var searchResults: [SearchGameList] { get set }
    func fetchGameList()
    func setSearchText(text: String)
}

class SearchViewModel: ObservableObject {
//    @Published var searchText: String = ""
    @Published var searchResults: [SearchGameList] = []
    @Published var isLoading: Bool = false
    
    private let networkService = NetworkService()
    private let router = Router()
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
                }
            }
        }
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
