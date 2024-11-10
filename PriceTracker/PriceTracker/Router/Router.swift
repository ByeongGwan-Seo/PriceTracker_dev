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
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showDetail() {
        navigationController
            .pushViewController(
                DetailViewController(
                    detailViewModel: DetailViewModel()
                ),
                animated: true
            )
    }
}
