//
//  DetailViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailThumbView: UIImageView!
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailRetailLabel: UILabel!
    @IBOutlet weak var detailUserPriceLabel: UILabel!
    @IBOutlet weak var detailCheapestLabel: UILabel!
    
    @IBOutlet weak var deatlTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deatlTableView.delegate = self
        deatlTableView.dataSource = self
        
    }
    
    @IBAction func addTrackingTapped(_ sender: UIButton) {
        print("add button tapped")
    }
}

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DealCell", for: indexPath) as? DealCell else { return UITableViewCell() }
        
        cell.dealPriceLabel.text = String(30)
        cell.dealStoreLabel.text = String(1)
        
        return cell
    }
    
    
}
