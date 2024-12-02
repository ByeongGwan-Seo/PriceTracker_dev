//
//  ViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit
import SwiftUI

class TrackingViewController: UIViewController {
    private let trackingViewModel = TrackingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let trackingView = TrackingView(trackingViewModel: trackingViewModel)
        let hostingController = UIHostingController(rootView: trackingView)

        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
