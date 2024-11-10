//
//  Router.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import UIKit

protocol RouterProtocol {
    func showDetail(navigationController: UINavigationController)
}

class Router: RouterProtocol {
    
    func showDetail(navigationController: UINavigationController) {
        navigationController
            .pushViewController(
                DetailViewController(
                    detailViewModel: DetailViewModel()
                ),
                animated: true
            )
    }
}
