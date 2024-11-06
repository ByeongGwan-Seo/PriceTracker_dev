//
//  SearchViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    private let searchViewModel: SearchViewModelProtocol
    private let router: RouterProtocol
    
    init(searchViewModel: SearchViewModelProtocol, router: RouterProtocol) {
        self.searchViewModel = searchViewModel
        self.router = router
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchView = SearchView(searchViewModel: searchViewModel)
        let hostingController = UIHostingController(rootView: searchView)
        
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    // TODO: Router処理
    
    func moveToDetail() {
        router.showDetail(owner: self)
    }
}

protocol RouterProtocol {
    func showDetail(owner: UIViewController)
}


class Router: RouterProtocol {
    func showDetail(owner: UIViewController) {
        // TODO:
    }
    
    
}
