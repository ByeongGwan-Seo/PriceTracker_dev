//
//  SearchViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit

class SearchViewController: UIViewController {

    
    var networkService = NetworkService()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.networkService.title = self.searchBar.text ?? ""
//        networkService.requestGameAPI(completion: <#T##(Result<GameList, Error>) -> Void#>)
        
        self.view.endEditing(true)
    }
}
