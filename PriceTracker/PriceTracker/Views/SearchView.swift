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
