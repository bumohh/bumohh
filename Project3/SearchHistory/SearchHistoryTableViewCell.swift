//
//  SearchHistoryTableViewCell.swift
//  Project3
//
//  Created by Bruno Gomez on 6/4/21.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
