//
//  ViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit
import AlamofireImage
import Alamofire

class TrackingViewController: UIViewController {

    @IBOutlet weak var trackingTableView: UITableView!
    
    private var trackingList = [TrackingInfo]() {
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
            if let trackingInfo = notification.object as? TrackingInfo {
                self.trackingList.append(trackingInfo)
                self.trackingTableView.reloadData()
            }
        }
    }
    
    private func saveTrackingList() {
        let data = self.trackingList.map {
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
        self.trackingList = data.compactMap {
            guard let uuidString = $0["uuidString"] as? String else { return nil }
            guard let title = $0["title"] as? String else { return nil }
            guard let price = $0["price"] as? String else { return nil }
            guard let retailPrice = $0["retailPrice"] as? String else { return nil }
            guard let userPrice = $0["userPrice"] as? String else { return nil }
            guard let gameID = $0["gameID"] as? String else { return nil }
            guard let thumb = $0["thumb"] as? String else { return nil }
            guard let isTracked = $0["isTracked"] as? Bool else { return nil }
            return TrackingInfo(uuidString: uuidString,
                                title: title,
                                price: price,
                                retailPrice: retailPrice,
                                userPrice: userPrice,
                                gameID: gameID,
                                thumb: thumb,
                                isTracked: true)
        }
    }
}

//extension TrackingViewController: AddTrackingDelegate {
//    func didSelectRegister(trackingInfo: TrackingInfo) {
//        self.trackingList.append(trackingInfo)
//        self.trackingTableView.reloadData()
//    }
//}

extension TrackingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.networkService.id = trackingList[indexPath.row].gameID ?? ""
        networkService.fetchDetail { result in
            switch result {
            case .success(let trackingList):
                detailVC.detailInfo = trackingList
                DispatchQueue.main.async {
                    detailVC.detailTitleLabel.text = detailVC.detailInfo?.info.title
                    detailVC.detailRetailLabel.text = (detailVC.detailInfo?.deals.first?.retailPrice ?? "N/A") + " $"
                    detailVC.detailCheapestLabel.text = (detailVC.detailInfo?.deals.first?.price ?? "N/A") + " $"
                    detailVC.gameID = self.trackingList[indexPath.row].gameID ?? ""
                    
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

extension TrackingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackingCell", for: indexPath) as? TrackingCell else { return UITableViewCell() }
        
        cell.gameTitleLabel.text = trackingList[indexPath.row].title
        cell.userPriceLabel.text = (trackingList[indexPath.row].userPrice ?? "") + " $"
        cell.cheapestLabel.text = trackingList[indexPath.row].price + " $"
        
        if let imageURL = URL(string: trackingList[indexPath.row].thumb ) {
            cell.thumbImageView.af.setImage(withURL: imageURL)
        }
        
        return cell
    }
}

