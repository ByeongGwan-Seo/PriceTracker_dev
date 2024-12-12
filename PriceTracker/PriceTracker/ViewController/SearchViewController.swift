//
//  SearchViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    private let searchViewModel = SearchViewModel()
    private var hostingController: UIHostingController<SearchView>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchView = SearchView(searchViewModel: searchViewModel)
        hostingController = UIHostingController(rootView: searchView)

        if let hostingController = hostingController {
            addChild(hostingController)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)

            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        }
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


