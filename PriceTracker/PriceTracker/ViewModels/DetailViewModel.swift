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
    
    init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }
    
    func fetchDetail() {
        
    }
}
