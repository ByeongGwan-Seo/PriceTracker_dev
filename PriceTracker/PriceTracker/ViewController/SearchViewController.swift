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
    var trackingListInApp: [TrackingInfoInApp]?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadTrackingList()
    }
    
    private func loadTrackingList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "trackingList") as? [[String: Any]] else { return }
        self.trackingListInApp = data.compactMap {
            let uuidString = $0["uuidString"]
            let title = $0["title"]
            let price = $0["price"]
            let retailPrice = $0["retailPrice"]
            let userPrice = $0["userPrice"]
            let gameID = $0["gameID"]
            let thumb = $0["thumb"]
            let isTracked = $0["isTracked"]

            return TrackingInfoInApp(uuidString: uuidString as? String ?? "",
                                title: title as? String ?? "",
                                price: price as? String ?? "",
                                retailPrice: retailPrice as? String ?? "",
                                userPrice: userPrice as? String ?? "",
                                gameID: gameID as? String ?? "",
                                thumb: thumb as? String ?? "",
                                isTracked: isTracked as? Bool ?? true
            )
        }
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
                    detailVC.detailRetailLabel.text = (detailVC.detailInfo?.deals.first?.retailPrice ?? "N/A") + " $"
                    detailVC.detailCheapestLabel.text = (detailVC.detailInfo?.deals.first?.price ?? "N/A") + " $"
                    detailVC.gameID = self.gameList[indexPath.row].gameID ?? ""
                    
                    let trackingIDList = self.trackingListInApp?.filter({ compareTrackingInfo in
                        if self.gameList[indexPath.row].gameID == compareTrackingInfo.gameID {
                            return true
                        }
                        return false
                    }) ?? []
                    
//                    let searchResult = self.trackingListInApp?.contains(where: { compareTrackingInfo in
//                        if self.gameList[indexPath.row].gameID == compareTrackingInfo.gameID {
//                            return true
//                        }
//                        return false
//                    }) ?? false
//
//                    if searchResult {
//                        detailVC.addToTrackingBtn.isEnabled = false
//                    } else {
//                        detailVC.addToTrackingBtn.isEnabled = true
//                    }
                    
//                    print(self.gameList[indexPath.row].gameID)
//                    print(self.trackingListInApp?.first?.gameID)
//                    print(trackingIDList.first?.gameID)
                    if !trackingIDList.isEmpty {
                        detailVC.addToTrackingBtn.isEnabled = false
                        detailVC.addToTrackingBtn.setTitle("Tracking...", for: .disabled)
                    } else {
                        detailVC.addToTrackingBtn.isEnabled = true
                    }
                    
//                    let hasID = self.trackingListInApp?.contains("trackingList 안의 객체의 gameID")
                    
//                    if self.gameList[indexPath.row].gameID == self.trackingListInApp?.first?.gameID {
////                        print(self.gameList[indexPath.row].gameID)
////                        print(self.trackingListInApp?.first?.gameID)
//                        detailVC.addToTrackingBtn.isEnabled = false
//                    }
                    
                    
                    
                    if let imageURL = URL(string: detailVC.detailInfo?.info.thumb ?? "") {
                        detailVC.detailThumbView.af.setImage(withURL: imageURL)
                    }
                    detailVC.deatlTableView.reloadData()
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
        
        //push와 modal(present)의 차이점
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
