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
                SearchHeaderView(
                    searchText: $searchText,
                    setSearchTextAction: searchViewModel.setSearchText,
                    fetchGameListAction: searchViewModel.fetchGameList
                )
                switch searchViewModel.status {
                case .loading:
                    EmptyView()
                case .content(let items):
                    SearchListView(items: items)
                case .noContent:
                    NoContentView()
                }
                
                Spacer()
            }
        }
        .alert(
            item: $searchViewModel.alertMessage,
            content: { message in
                Alert(
                    title: Text("Error"),
                    message: Text(message.message),
                    dismissButton:.default( Text("OK"))
                )
            }
        )
    }
}

fileprivate struct SearchHeaderView: View {
    @Binding private var searchText: String
    
    private let setSearchTextAction: (String) -> Void
    private let fetchGameListAction: () -> Void
    
    
    init(
        searchText: Binding<String>,
        setSearchTextAction: @escaping (String) -> Void,
        fetchGameListAction: @escaping () -> Void
    ) {
        self._searchText = searchText
        self.setSearchTextAction = setSearchTextAction
        self.fetchGameListAction = fetchGameListAction
    }
    
    var body: some View {
        TextField("Enter game title", text: $searchText)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .submitLabel(.search)
            .onSubmit {
                setSearchTextAction(searchText)
                fetchGameListAction()
            }
            .padding(.top, 20)
    }
}

fileprivate struct NoContentView: View {
    var body: some View {
        Text("No results found.")
            .padding()
    }
}

fileprivate struct SearchListView: View {
    private let items: [GameTitle]
    
    init(items: [GameTitle]) {
        self.items = items
    }
    
    var body: some View {
        List( items, id: \.gameID ) { game in
            NavigationLink(
                destination: DetailView(
                    detailViewModel: DetailViewModel(gameId: game.gameID)
                )
            ) { Text(
                game.external
            ) .padding()
            }
        }
        .listStyle(
            .plain
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        class MockSearchViewModel: SearchViewModel {
            override init() {
                super.init()
                self.searchResults = [
                    GameTitle(
                        gameID: "1",
                        steamAppID: "1001",
                        cheapest: "5.99",
                        cheapestDealID: "deal_001",
                        external: "https://game1.com",
                        thumb: "thumb1"
                    ), GameTitle(
                        gameID: "2",
                        steamAppID: "1002",
                        cheapest: "9.99",
                        cheapestDealID: "deal_002",
                        external: "https://game2.com",
                        thumb: "thumb2"
                    ), GameTitle(
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
        return SearchView(searchViewModel: MockSearchViewModel())
    }
}

