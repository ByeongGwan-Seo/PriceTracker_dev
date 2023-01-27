//
//  DetailViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/20.
//

import UIKit
import AlamofireImage
import SafariServices

let trackingNotification = NSNotification.Name(rawValue: "trackingNotification")

class DetailViewController: UIViewController {
    
    var detailInfo: DetailModel?
    var trackingList: [TrackingInfo]?
    var networkService = NetworkService()
    var textFieldOnAlert = UITextField()
    
    var gameID: String?
//    weak var delegate: AddTrackingDelegate?
    
    @IBOutlet weak var detailThumbView: UIImageView!
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailRetailLabel: UILabel!
    @IBOutlet weak var detailCheapestLabel: UILabel!
    
    @IBOutlet weak var deatlTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deatlTableView.delegate = self
        deatlTableView.dataSource = self
    }
    
    @IBAction func addTrackingTapped(_ sender: UIButton) {
        print("add button tapped")
        let alert = UIAlertController(title: "Notice", message: "Please enter the price you want", preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default) { (ok) in
            let trackingInfo = TrackingInfo(uuidString:UUID().uuidString,
                                            title: self.detailInfo?.info.title ?? "",
                                            price: self.detailInfo?.deals.first?.price ?? "0.0",
                                            retailPrice: self.detailInfo?.deals.first?.retailPrice ?? "0.0",
                                            userPrice: self.textFieldOnAlert.text ?? "0.0",
                                            gameID: self.gameID ?? "",
                                            thumb: self.detailInfo?.info.thumb ?? "",
                                            isTracked: true)
            
            NotificationCenter.default.post(name: trackingNotification, object: trackingInfo)

            
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
        
        if let imageURL = URL(string: urlString) {
            cell.storeLogoView.af.setImage(withURL: imageURL)
        }
        
        return cell
    }
}


//extension UIApplication {
//
//    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//
//        if let nav = base as? UINavigationController {
//            return getTopViewController(base: nav.visibleViewController)
//
//        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
//            return getTopViewController(base: selected)
//
//        }
//       else if let presented = base?.presentedViewController {
//            return getTopViewController(base: presented)
//        }
//        return base
//    }
//}

