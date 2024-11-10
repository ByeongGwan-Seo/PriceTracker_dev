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
    // 現在SearchViewの構造で下のsearchTextやsearchResultsを使うにはどうすればよろしいでしょうか。
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
        Future<[SearchGameList], Error> { promise in
                Task {
                    do {
                        let gameList = try await self.networkService.fetchGameList(title: self.searchText)
                        promise(.success(gameList))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure:
                    self.isLoading = false
                    print("error occured")
                }
            }, receiveValue: { gameList in
                self.searchResults = gameList
            })
            .store(in: &cancellables)
        }
    
    func moveToDetail() {
        router.showDetail()
    }
}
