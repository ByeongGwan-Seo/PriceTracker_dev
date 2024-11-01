//
//  DetailViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/20.
//

import UIKit

import SafariServices

let trackingNotification = NSNotification.Name(rawValue: "trackingNotification")

class DetailViewController: UIViewController {
  
  //var 앱내에서쓰는모델 = 네트워크
  var detailInfo: DetailModel?
  var trackingList: [TrackingInfo]?
  var trackingListInApp: [TrackingInfoInApp]?
  var networkService = NetworkService()
  var textFieldOnAlert = UITextField()
  
  var gameID: String?
  
  //    weak var delegate: AddTrackingDelegate?
  
  @IBOutlet weak var detailThumbView: UIImageView!
  
  @IBOutlet weak var detailTitleLabel: UILabel!
  @IBOutlet weak var detailRetailLabel: UILabel!
  @IBOutlet weak var detailCheapestLabel: UILabel!
  
  @IBOutlet weak var addToTrackingBtn: UIButton!
  @IBOutlet weak var deatlTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    deatlTableView.delegate = self
    deatlTableView.dataSource = self
  }
  
  
  
  @IBAction func addTrackingTapped(_ sender: UIButton) {
    print("add button tapped")
    
    alertAction()
  }
  
  func alertAction() {
    let alert = UIAlertController(title: "Notice", message: "Please enter the price you want", preferredStyle: .alert)
    let save = UIAlertAction(title: "Save", style: .default) { (ok) in
      let trackingInfo = TrackingInfoInApp(uuidString:UUID().uuidString,
                                           title: self.detailInfo?.info.title ?? "",
                                           price: self.detailInfo?.deals.first?.price ?? "0.0",
                                           retailPrice: self.detailInfo?.deals.first?.retailPrice ?? "0.0",
                                           userPrice: self.textFieldOnAlert.text ?? "0.0",
                                           gameID: self.gameID ?? "",
                                           thumb: self.detailInfo?.info.thumb ?? "",
                                           isTracked: true
      )
      
      NotificationCenter.default.post(name: trackingNotification, object: trackingInfo)
      
      self.addToTrackingBtn.isEnabled = false
      self.dismiss(animated: true)
      //            if let trackingViewController = UIApplication.getTopViewController()?.tabBarController?.viewControllers?[0] as? TrackingViewController {
      //                self.delegate = trackingViewController
      //            }
      
      //            self.delegate?.didSelectRegister(trackingInfo: trackingInfo)
    }
    
    let no = UIAlertAction(title: "Cancel", style: .destructive) { (no) in
      self.textFieldOnAlert.text = ""
    }
    
    alert.addTextField { textField in
      self.textFieldOnAlert = textField
      self.textFieldOnAlert.returnKeyType = .done
    }
    
    alert.addAction(no)
    alert.addAction(save)
    
    present(alert, animated: true, completion: nil)
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

extension DetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    let dealID = detailInfo?.deals[indexPath.row].dealID
    let urlString = NSURL(string: "https://www.cheapshark.com/redirect?dealID=\(dealID ?? "")")
    let dealView: SFSafariViewController = SFSafariViewController(url: urlString! as URL)
    self.present(dealView, animated: true)
  }
}

extension DetailViewController:UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return detailInfo?.deals.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DealCell", for: indexPath) as? DealCell else { return UITableViewCell() }
    
    cell.dealPriceLabel.text = (detailInfo?.deals[indexPath.row].price ?? "") + " $"
    
    let storeID = Int(detailInfo?.deals[indexPath.row].storeID ?? "") ?? 0
    let urlString = "https://www.cheapshark.com/img/stores/logos/\(storeID - 1).png"
    
    Task {
      if let imageURL = URL(string: urlString) {
        do {
          let (data, _) = try await URLSession.shared.data(from: imageURL)
          
          if let image = UIImage(data: data) {
            cell.storeLogoView.image = image
          }
        } catch {
          print("image loading error: (\(error)")
        }
      }
    }

    return cell
  }
}

