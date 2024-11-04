//
//  SearchView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var searchResults: [SearchGameList] = []
    @State private var isLoading: Bool = false
    
    private let networkService:NetworkServiceProtocol = NetworkService()
    
    var body: some View {
        VStack {
            TextField("Search Here", text: $searchText)
                .onSubmit {
                    fetchGameList()
                }
                .textFieldStyle(.roundedBorder)
                .padding()
            
            
            if isLoading {
                ProgressView()
            }
            List {
                ForEach(searchResults, id: \.self) { result in
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
    
    private func fetchGameList() {
        Task {
            do {
                searchResults = try await networkService.fetchGameList(title: searchText)
                searchText = ""
            } catch {
                print("error while fetching game list: \(error)")
            }
        }
    }
}

#Preview {
    SearchView()
}
