//
//  ViewController.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/18.
//

import UIKit

class TrackingViewController: UIViewController {

    @IBOutlet weak var trackingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trackingTableView.delegate = self
        trackingTableView.dataSource = self
        
        trackingTableView.reloadData()
    }
}

extension TrackingViewController: UITableViewDelegate {
    
}

extension TrackingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackingCell", for: indexPath) as? TrackingCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

