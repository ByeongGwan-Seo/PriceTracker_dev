//
//  Router.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import UIKit

protocol RouterProtocol {
    func showDetail()
}

class Router: RouterProtocol {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showDetail() {
        let networkService = NetworkService()
        let detailViewModel = DetailViewModel(networkService: networkService)
        
        let detailViewController = DetailViewController(detailViewModel: detailViewModel)
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
