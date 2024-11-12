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
        if detailViewModel.isLoading {
            Text("detail is loading")
        } else {
            Text("detail is loaded")
        }
    }
}


