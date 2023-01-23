//
//  DealCell.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/23.
//

import UIKit

class DealCell: UITableViewCell {

    
    
    @IBOutlet weak var dealLogoView: UIImageView!
    @IBOutlet weak var dealStoreLabel: UILabel!
    @IBOutlet weak var dealPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
