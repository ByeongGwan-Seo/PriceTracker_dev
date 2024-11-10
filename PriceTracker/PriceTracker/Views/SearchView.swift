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
//이런 식으로도 사용할 수 있음
//                Foo(action: searchViewModel.moveToDetail)
            }
        }
    }
}

//각 컴포넌트의 라이브러리를 보고 사용할 수 있을지 여부를 판단할 수 있다.
//struct Foo: View {
//isLoacing:Bool
//    private let  viewModel: SearchViewModelProtocol
////    private let action: () -> Void
//    
//    init(action: @escaping () -> Void) {
//        self.action = action
//    }
//    
//    var body: some View {
//        Button(action: {viewModel.moveToDetail()}) {
//            Text("Hello, World!")
//        }
//    }
//}

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
