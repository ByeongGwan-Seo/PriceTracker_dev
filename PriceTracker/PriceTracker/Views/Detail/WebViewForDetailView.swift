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
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
