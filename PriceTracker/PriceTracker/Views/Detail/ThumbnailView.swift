//
//  ThumbnailView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/21.
//

import SwiftUI

struct ThumbnailView: View {
    private let urlString: String
    
    init(
        urlString: String
    ) {
        self.urlString = urlString
    }
    
    var body: some View {
        AsyncImage(
            url: URL(
                string: urlString
            )
        ) { image in
            image
                .resizable()
                .frame(
                    width: 50,
                    height: 50
                )
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    ThumbnailView(
        urlString: ""
    )
}
