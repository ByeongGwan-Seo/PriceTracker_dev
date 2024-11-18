//
//  SearchViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import Combine

enum ScreenStatus {
    case loading
    case content(items: [GameTitle])
    case noContent
    case error
}

class SearchViewModel: ObservableObject {
    @Published var contents: [GameTitle] = [] {
        didSet {
            if self.contents.isEmpty {
                status = .noContent
            }
        }
    }
    
    @Published var status: ScreenStatus = .loading
    @Published var alertMessage: AlertMessage?
    
    private let networkService = NetworkService()
    private var searchText: String = ""
    
    func fetchGameList() {
        status = .loading
        Task {
            do {
                let items = try await self.networkService.fetchGameList(title: self.searchText)
                status = .content(items: items)
                await MainActor.run {
                    self.contents = items
                }
            } catch {
                status = .error
                await MainActor.run {
                    alertMessage = AlertMessage(message: "検索中エラーが発生しました。\n\(error)")
                }
            }
        }
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
