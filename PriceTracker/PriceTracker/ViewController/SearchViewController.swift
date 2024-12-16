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
    private lazy var hostingController: UIHostingController<SearchView> = {
        UIHostingController(rootView: SearchView(searchViewModel: searchViewModel))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchView = SearchView(searchViewModel: searchViewModel)
        hostingController = UIHostingController(rootView: searchView)

        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        setupConstraints(for: hostingController)

    }

    private func setupConstraints(for hostingController: UIHostingController<SearchView>) {
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate { [weak self] _ in
            guard let self = self else { return }
            self.hostingController.view.frame = self.view.bounds
            self.hostingController.view.setNeedsLayout()
            self.hostingController.view.layoutIfNeeded()
        }
    }
}


