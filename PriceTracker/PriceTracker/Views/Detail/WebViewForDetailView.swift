//
//  WebViewForDetailView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/20.
//

import SwiftUI
import WebKit

struct WebViewForDetailView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}
