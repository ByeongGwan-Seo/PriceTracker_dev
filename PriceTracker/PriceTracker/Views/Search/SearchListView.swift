//
//  SearchListView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/20.
//

import SwiftUI

struct SearchListView: View {
    private let items: [GameTitle]
    
    init(items: [GameTitle]) {
        self.items = items
    }
    
    var body: some View {
        List(items, id: \.gameID) { game in
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

#Preview("SearchListView Preview") {
    SearchListView(items: [
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
    ])
}
