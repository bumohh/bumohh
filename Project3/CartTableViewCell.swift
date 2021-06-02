//
//  CartTableViewCell.swift
//  Project3
//
//  Created by Bruno Gomez on 6/2/21.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var clothingImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
