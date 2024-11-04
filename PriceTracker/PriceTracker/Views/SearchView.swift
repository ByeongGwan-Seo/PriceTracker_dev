//
//  SearchView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    
    private let networkService:NetworkServiceProtocol = NetworkService()
    
    var body: some View {
        VStack {
            
            SearchTextField(searchText: $searchViewModel.searchText) {
                searchViewModel.search()
            }
            
            if searchViewModel.isLoading {
                ProgressView()
            }
            
            SearchResultList(searchResults: searchViewModel.searchResults)
            
        }
    }
}

struct SearchTextField: View {
    @Binding var searchText: String
    var onSubmit: () -> Void
    
    var body: some View {
        TextField("Search Here", text: $searchText)
            .onSubmit {
                onSubmit()
            }
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}

struct SearchResultList: View {
    var searchResults: [SearchGameList]
    
    var body: some View {
        List {
            ForEach(searchResults, id: \.gameID) { result in
                HStack {
                    AsyncImage(url: URL(string: result.thumb ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(result.external ?? "Game does not exist")
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    SearchView()
}
