//
//  DetailViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI

protocol DetailViewModelProtocol {
    var isLoading: Bool { get set }
    func fetchDetail()
}

class DetailViewModel: DetailViewModelProtocol, ObservableObject {
    @Published var isLoading: Bool = false
    
    private let networkService: NetworkServiceProtocol
    private var gameId: String
    
    init(
        networkService: NetworkServiceProtocol,
        gameId: String
    ) {
        self.networkService = networkService
        self.gameId = gameId
    }
    
    func fetchDetail() {
        
    }
}
