//
//  DetailView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI

struct DetailView: View {
    var detailViewModel: DetailViewModelProtocol
    
    init(detailViewModel: DetailViewModelProtocol) {
        self.detailViewModel = detailViewModel
    }
    var body: some View {
        if detailViewModel.isLoading {
            Text("detail is loading")
        } else {
            Text("detail is loaded")
        }
    }
}

struct TotalPreviews: PreviewProvider {
    static var previews: some View {
        
        class MockDetailViewModel: DetailViewModelProtocol {
            func fetchDetail() {}
            var isLoading: Bool = false
        }

        class MockSearchViewModel: SearchViewModelProtocol {
            var searchText: String = "test"
            var isLoading: Bool = true
            var searchResults: [SearchGameList] = []
            
            func fetchGameList() {}
            func moveToDetail() {}
        }
        
        return Group {
            DetailView(detailViewModel: MockDetailViewModel())
            SearchView(searchViewModel: MockSearchViewModel())
        }
    }
}


