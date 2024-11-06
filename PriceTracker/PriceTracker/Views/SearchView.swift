//
//  SearchView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/04.
//

import SwiftUI

struct SearchView: View {
    var searchViewModel: SearchViewModelProtocol
    
    init(searchViewModel: SearchViewModelProtocol) {
        self.searchViewModel = searchViewModel
    }
    
    var body: some View {
        VStack {
            if searchViewModel.isLoading {
                Text("is Loading")
            } else {
                Text("search results")
            }
        }
    }
}

struct SampleButton_Previews: PreviewProvider {
    static var previews: some View {
        class MockViewModel: SearchViewModelProtocol {
            var searchText: String = "test"
            
            var isLoading: Bool = true
            
            var searchResults: [SearchGameList] = []
            
            func search() {}
            
            func fetchGameList() {}
        }
        let viewModel = MockViewModel()
        return SearchView(searchViewModel: viewModel)
    }
}
