//
//  DetailViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/20.
//

import UIKit
import AlamofireImage
import SafariServices

class DetailViewController: UIViewController {

    
    var detailInfo: DetailModel?
    var networkService = NetworkService()
    
    @IBOutlet weak var detailThumbView: UIImageView!
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailRetailLabel: UILabel!
    @IBOutlet weak var detailCheapestLabel: UILabel!
    
    @IBOutlet weak var deatlTableView: UITableView!
    
    var textFieldOnAlert = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        deatlTableView.delegate = self
        deatlTableView.dataSource = self
        
        
    }
    
    @IBAction func addTrackingTapped(_ sender: UIButton) {
        print("add button tapped")
        let alert = UIAlertController(title: "Notice", message: "Please enter the price you want", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Save", style: .default) { (ok) in
            
            
        }
        let no = UIAlertAction(title: "Cancel", style: .destructive) { (no) in
            
        }
        
        alert.addTextField { textField in
            self.textFieldOnAlert = textField
            self.textFieldOnAlert.returnKeyType = .done
        }
        alert.addAction(no)
        alert.addAction(yes)
        
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
