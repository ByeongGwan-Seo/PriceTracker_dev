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
    private var hostingController: UIHostingController<TrackingView>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let trackingView = TrackingView(trackingViewModel: trackingViewModel)
        hostingController = UIHostingController(rootView: trackingView)

        guard let hostingController = hostingController else { return }

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate { _ in
            self.hostingController?.view.frame = self.view.bounds
            self.hostingController?.view.setNeedsLayout()
            self.hostingController?.view.layoutIfNeeded()
        }
    }
}
