//
//  DetailViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/20.
//

import UIKit

class DetailViewController: UIViewController {

    
    var detailInfo: DetailModel?
    var networkService = NetworkService()
    
    @IBOutlet weak var detailThumbView: UIImageView!
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailRetailLabel: UILabel!
    @IBOutlet weak var detailUserPriceLabel: UILabel!
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
    
}

extension DetailViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DealCell", for: indexPath) as? DealCell else { return UITableViewCell() }
        
        cell.dealPriceLabel.text = String(30)
        cell.dealStoreLabel.text = String(1)
        
        return cell
    }
    
    
}
