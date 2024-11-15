//
//  DetailView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var detailViewModel: DetailViewModel
    
    var body: some View {
        VStack {
            if detailViewModel.isLoading {
                ProgressView()
            } else {
                if let detail = detailViewModel.gameDetail {
                    HStack {
                        AsyncImage(url: URL(string: detail.info.thumb)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .onAppear(perform: detailViewModel.fetchDetail)
    }
}


