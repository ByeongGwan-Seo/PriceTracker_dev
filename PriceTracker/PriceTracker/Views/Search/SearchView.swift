//
//  SearchView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import SwiftUI
import Combine

struct SearchView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @State var searchText: String = ""
    var body: some View {
        NavigationView {
            VStack {
                SearchHeader(
                    searchText: $searchText,
                    setSearchTextAction: searchViewModel.setSearchText,
                    fetchGameListAction: searchViewModel.fetchGameList
                )
                switch searchViewModel.status {
                case .loading:
                    ProgressView()
                case .success(let contents):
                    SearchListView(items: contents)
                case .noContent:
                    NoContentView()
                case .error:
                    EmptyView()
                }
                Spacer()
                
            }
        }
        .alert(
            item: $searchViewModel.errorMessage,
            content: { message in
                Alert(
                    title: Text(L10n.errorAlertTitle),
                    message: Text(message.message),
                    dismissButton: .default(Text(L10n.alertDismissOk))
                )
            }
        )
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        class MockSearchViewModel: SearchViewModel {
            override init() {
                super.init()
                self.contents = [
                    GameTitle(
                        gameID: "1",
                        steamAppID: "1001",
                        cheapest: "5.99",
                        cheapestDealID: "deal_001",
                        external: "https://game1.com",
                        thumb: "thumb1"
                    ),
                    GameTitle(
                        gameID: "2",
                        steamAppID: "1002",
                        cheapest: "9.99",
                        cheapestDealID: "deal_002",
                        external: "https://game2.com",
                        thumb: "thumb2"
                    ),
                    GameTitle(
                        gameID: "3",
                        steamAppID: "1003",
                        cheapest: "12.99",
                        cheapestDealID: "deal_003",
                        external: "https://game3.com",
                        thumb: "thumb3"
                    )
                ]
            }
        }
        return SearchView(
            searchViewModel: MockSearchViewModel()
        )
    }
}

