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


