//
//  SearchHeader.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/20.
//

import SwiftUI

struct SearchHeader: View {
    @Binding private var searchText: String

    private var setSearchTextAction: (String) -> Void
    private var fetchGameListAction: () -> Void

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
        TextField(L10n.searchPlaceholder, text: $searchText)
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
