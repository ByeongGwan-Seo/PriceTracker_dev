//
//  ViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit
import AlamofireImage

class TrackingViewController: UIViewController {

    @IBOutlet weak var trackingTableView: UITableView!
    
    private var trackingList = [TrackingInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTrackingTable()
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
}

//extension TrackingViewController: AddTrackingDelegate {
//    func didSelectRegister(trackingInfo: TrackingInfo) {
//        self.trackingList.append(trackingInfo)
//        self.trackingTableView.reloadData()
//    }
//}


extension TrackingViewController: UITableViewDelegate {
    
}

extension TrackingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackingCell", for: indexPath) as? TrackingCell else { return UITableViewCell() }
        
        cell.gameTitleLabel.text = trackingList[indexPath.row].title
        cell.userPriceLabel.text = trackingList[indexPath.row].userPrice
        cell.cheapestLabel.text = trackingList[indexPath.row].price
        
        if let imageURL = URL(string: trackingList[indexPath.row].thumb ) {
            cell.thumbImageView.af.setImage(withURL: imageURL)
        }
        
        return cell
    }
}

