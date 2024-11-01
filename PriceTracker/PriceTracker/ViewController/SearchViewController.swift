//
//  SearchViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit

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
  
  func showDetail(for indexPath: IndexPath) async {
    guard let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
    
    let gameId = self.gameList[indexPath.row].gameID ?? ""
    do {
      let detailInfo = try await networkService.fetchDetail(gameId: gameId)
      DispatchQueue.main.async {
        detailVC.detailInfo = detailInfo
        
        let trackingIdList = self.trackingListInApp?.filter {
          $0.gameID == self.gameList[indexPath.row].gameID
        } ?? []

        DispatchQueue.main.async {
          self.present(detailVC, animated: true)
        }
      }
    } catch {
      print("error fetching detail: \(error)")
    }
  }
  
  func fetchGame() async {
    self.networkService.title = self.searchBar.text ?? ""
    do {
      let fetchedGameList = try await networkService.fetchGameAPI()
      self.gameList = fetchedGameList
      
      DispatchQueue.main.async {
        self.searchTableView.reloadData()
        self.view.endEditing(true)
      }
    } catch {
      let alert = UIAlertController(title: "Error", message: "Failed to fetch games. Please try again.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(alert, animated: true)
    }
  }
}

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    Task {
      await showDetail(for: indexPath)
    }
  }
}

extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.gameList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UITableViewCell() }
    
    cell.searchTitleLabel.text = gameList[indexPath.row].external
    
    Task {
      if let imageURL = URL(string: gameList[indexPath.row].thumb ?? "") {
        do {
          let (data, _) = try await URLSession.shared.data(from: imageURL)
          
          if let image = UIImage(data: data) {
            cell.searchThumbView.image = image
          }
        } catch {
          print("image loading error: (\(error)")
        }
      }
    }
    
    return cell
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    Task {
      await fetchGame()
    }
  }
}



