//
//  HeaderCollectionReusableView.swift
//  Project3
//
//  Created by Tommy Phan on 5/26/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "HeaderCollectionReusableView"
    
    private let label: UILabel = {
//        var image = UIImage()
//        image = UIImage(named: "Home3")!
//
//        return image
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public func configure() {
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        
    }
}
