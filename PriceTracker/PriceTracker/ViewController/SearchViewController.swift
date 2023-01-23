//
//  SearchViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit
import AlamofireImage

class SearchViewController: UIViewController {

    var gameList: [SearchGameList] = []
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
        guard let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.networkService.id = gameList[indexPath.row].gameID ?? ""
        networkService.fetchDetail { result in
            switch result {
            case .success(let detailInfo):
                detailVC.detailInfo = detailInfo
                DispatchQueue.main.async {
                    detailVC.detailTitleLabel.text = detailVC.detailInfo?.info.title
                    detailVC.detailRetailLabel.text = detailVC.detailInfo?.deals.first?.retailPrice
                    detailVC.detailCheapestLabel.text = detailVC.detailInfo?.deals.first?.price
                    
                    if let imageURL = URL(string: detailVC.detailInfo?.info.thumb ?? "") {
                        detailVC.detailThumbView.af.setImage(withURL: imageURL)
                    }
                    detailVC.deatlTableView.reloadData()
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
        present(detailVC, animated: true)
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
