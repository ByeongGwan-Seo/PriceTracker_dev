//
//  SearchCell.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/19.
//

import UIKit

class SearchCell: UITableViewCell {

    
    @IBOutlet weak var searchThumbView: UIImageView!
    
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var searchReleaseLabel: UILabel!
    @IBOutlet weak var searchPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
