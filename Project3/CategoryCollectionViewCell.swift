//
//  CategoryCollectionViewCell.swift
//  Project3
//
//  Created by Tommy Phan on 6/8/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "CategoryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        return UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
    }
    
}
