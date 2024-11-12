//
//  DetailViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/20.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    private var detailViewModel = DetailViewModel?
    
    
    
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


