//
//  DetailViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/20.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    private let detailViewModel: DetailViewModelProtocol
    
    init(detailViewModel: DetailViewModelProtocol) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailView = DetailView(detailViewModel: detailViewModel)
        let hostingController = UIHostingController(rootView: detailView)
        
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}


