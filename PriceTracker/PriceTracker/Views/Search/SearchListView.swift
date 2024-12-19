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
