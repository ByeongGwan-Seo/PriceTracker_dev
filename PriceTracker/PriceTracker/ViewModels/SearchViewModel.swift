//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import SwiftUI

protocol SearchViewModelProtocol {
    var searchText: String { get set }
    var isLoading: Bool { get set }
    var searchResults: [SearchGameList] { get set }
    func fetchGameList()
    func moveToDetail(owner: UIViewController)
}

class SearchViewModel: SearchViewModelProtocol, ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [SearchGameList] = []
    @Published var isLoading: Bool = false
    
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol
    
    init(
            networkService: NetworkServiceProtocol = NetworkService(),
            router: RouterProtocol
        ) {
            self.networkService = networkService
            self.router = router
        }
    
    func fetchGameList() {

    }
    
    func moveToDetail(owner: UIViewController) {
        router.showDetail(owner: owner)
    }
}
