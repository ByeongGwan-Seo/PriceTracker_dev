//
//  SearchView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import SwiftUI

struct SearchView: View {
    // 現在、この様にprotocolを採択してviewModelを呼んでいます。
    var searchViewModel: SearchViewModelProtocol
    
    init(searchViewModel: SearchViewModelProtocol) {
        self.searchViewModel = searchViewModel
    }
    
    var body: some View {
        VStack {
            if searchViewModel.isLoading {
                Text("search is Loading")
            } else {
                Button(action: searchViewModel.moveToDetail) {
                    Text("Go to Detail View")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        class MockViewModel: SearchViewModelProtocol {
            func moveToDetail() {
                searchText = "detail here"
            }
            
            var searchText: String = "test"
            
            var isLoading: Bool = false
            
            var searchResults: [SearchGameList] = []
            
            
            func fetchGameList() {}
        }
        let viewModel = MockViewModel()
        return SearchView(searchViewModel: viewModel)
    }
}
