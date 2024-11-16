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
        // TODO: 「確か　Task 自体に @mainactorを追加すると await MainActor.run を使わなくても Mainにできてた気がします。」→concurrency勉強して確認すること
        Task {
            do {
                let gameList = try await self.networkService.fetchGameList(title: self.searchText)
                status = .content(items: gameList)
                await MainActor.run {
                    self.contents = gameList
                }
            } catch {
                await MainActor.run {
                    status = ScreenStatus.error(message: "検索中エラーが発生しました。\n\(error)")
                }
            }
        }
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }
}
