//
//  SearchViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit
import AlamofireImage

class SearchViewController: UIViewController {

    var gameList: [GameList] = []
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UITableViewCell() }
        
        cell.searchTitleLabel.text = gameList[indexPath.row].external
        
        if let imageURL = URL(string: gameList[indexPath.row].thumb ?? "") {
            cell.searchThumbView.af.setImage(withURL: imageURL)
        }
        return cell
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.networkService.title = self.searchBar.text ?? ""
        networkService.fetchGameAPI { result in
            switch result {
            case .success(let gameList):
                self.gameList = gameList
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
        self.view.endEditing(true)
    }
}
