//
//  SearchViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    private var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchView = SearchView(searchViewModel: searchViewModel)
        let hostingController = UIHostingController(rootView: searchView)
        
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}


