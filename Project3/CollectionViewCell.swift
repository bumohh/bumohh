//
//  CollectionViewCell.swift
//  Project3
//
//  Created by Tommy Phan on 5/26/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemColor: UILabel!
    @IBOutlet var itemPrice: UILabel!
    
    static let identifier = "CollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configureImage(with image: UIImage) {
        imageView.image = image
    }
    public func configureItemName(with name: String) {
        itemName.text = name
    }
    public func configureItemColor(with color: String) {
        itemColor.text = color
    }
    public func configureItemPrice(with price: String) {
        itemPrice.text = price
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
}
