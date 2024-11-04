//
//  ViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit

class TrackingViewController: UIViewController {
  
    private var gameId: String = ""
    
  @IBOutlet weak var trackingTableView: UITableView!
  
  var trackingListInApp = [TrackingInfoInApp]() {
    didSet {
      self.saveTrackingList()
    }
  }
  private var networkService = NetworkService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTrackingTable()
    loadTrackingList()
  }
  
  private func configureTrackingTable() {
    trackingTableView.delegate = self
    trackingTableView.dataSource = self
    NotificationCenter.default.addObserver(forName: trackingNotification, object: nil, queue: .main) { notification in
      if let trackingInfo = notification.object as? TrackingInfoInApp {
        self.trackingListInApp.append(trackingInfo)
        self.trackingTableView.reloadData()
      }
    }
  }
  
  private func saveTrackingList() {
    let data = self.trackingListInApp.map {
      [
        "uuidString": $0.uuidString,
        "title": $0.title,
        "price": $0.price,
        "retailPrice": $0.retailPrice,
        "userPrice": $0.userPrice ?? "",
        "gameID": $0.gameID ?? "",
        "thumb": $0.thumb,
        "isTracked": $0.isTracked
      ]
    }
    let userDefaults = UserDefaults.standard
    userDefaults.set(data, forKey: "trackingList")
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

extension TrackingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    Task {
      await showDetail(for: indexPath)
    }
  }
  
  func showDetail(for indexPath: IndexPath) async {
    guard let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
    
      self.gameId = trackingListInApp[indexPath.row].gameID ?? ""
    
    do {
        let trackingList = try await networkService.fetchGameDetail(gameId: self.gameId)
      detailVC.detailInfo = trackingList
      
      DispatchQueue.main.async {
        detailVC.detailTitleLabel.text = detailVC.detailInfo?.info.title
        detailVC.detailRetailLabel.text = (detailVC.detailInfo?.deals.first?.retailPrice ?? "N/A") + " $"
        detailVC.detailCheapestLabel.text = (detailVC.detailInfo?.deals.first?.price ?? "N/A") + " $"
        detailVC.gameID = self.trackingListInApp[indexPath.row].gameID ?? ""
        
        if self.trackingListInApp[indexPath.row].isTracked == true {
          detailVC.addToTrackingBtn.isEnabled = false
          detailVC.addToTrackingBtn.setTitle("Tracking...", for: .disabled)
        } else {
          detailVC.addToTrackingBtn.isEnabled = true
        }
        
        if let imageURLString = detailVC.detailInfo?.info.thumb,
           let imageURL = URL(string: imageURLString) {
          Task {
            do {
              let (data, _) = try await URLSession.shared.data(from: imageURL)
              if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                  detailVC.detailThumbView.image = image
                }
              }
            } catch {
              print("image loading error: \(error)")
            }
          }
        }
        detailVC.deatlTableView.reloadData()
      }
      
      present(detailVC, animated: true)
    } catch {
      print("error: \(error)")
    }
  }
}

extension TrackingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return trackingListInApp.count
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      trackingListInApp.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    saveTrackingList()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackingCell", for: indexPath) as? TrackingCell else { return UITableViewCell() }
    
    cell.gameTitleLabel.text = trackingListInApp[indexPath.row].title
    cell.userPriceLabel.text = (trackingListInApp[indexPath.row].userPrice ?? "") + " $"
    cell.cheapestLabel.text = trackingListInApp[indexPath.row].price + " $"
    
    let imageURLString = trackingListInApp[indexPath.row].thumb
    if let imageURL = URL(string: imageURLString) {
      Task {
        do {
          let (data, _) = try await URLSession.shared.data(from: imageURL)
          if let image = UIImage(data: data) {
            DispatchQueue.main.async {
              cell.thumbImageView.image = image
            }
          }
        } catch {
          print("error: \(error)")
        }
      }
    }
    
    return cell
  }
}

