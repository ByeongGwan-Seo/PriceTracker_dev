//
//  Router.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import UIKit

protocol RouterProtocol {
    func showDetail(owner: UIViewController)
}


class Router: RouterProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let detailViewModel: DetailViewModelProtocol
    
    init(networkService: NetworkServiceProtocol, detailViewModel: DetailViewModelProtocol) {
        self.networkService = networkService
        self.detailViewModel = detailViewModel
    }
    
    func showDetail(owner: UIViewController) {
        let detailViewController = DetailViewController(detailViewModel: detailViewModel)
        owner.present(detailViewController, animated: true, completion: nil)
    }
}
