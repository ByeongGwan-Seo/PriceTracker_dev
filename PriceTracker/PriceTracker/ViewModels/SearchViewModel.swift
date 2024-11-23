//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import Combine

@MainActor
protocol SearchViewModelProtocol: ObservableObject {
    var contents: [GameTitle] { get set }
    var status: SearchScreenStatus { get  set }
    var errorMessage: ErrorMessage?  { get  set }
    
    
    func fetchGameList()
    func setSearchText(text: String)
}

class SearchViewModel: SearchViewModelProtocol {
    @Published var contents: [GameTitle] = []
    @Published var status: SearchScreenStatus = .noContent
    @Published var errorMessage: ErrorMessage?
    
    private let networkService: NetworkServiceProtocol
    private var searchText: String = ""
    
    init (networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
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
                    errorMessage = ErrorMessage(message: "検索中エラーが発生しました。\n\(error)")
                }
            }
        }
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
