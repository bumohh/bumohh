//
//  ShippingTableViewCell.swift
//  Project3
//
//  Created by Edward Guilllermo on 6/4/21.
//

import UIKit

class ShippingTableViewCell: UITableViewCell {
    var orders = DatabaseHelper.inst.fetchOrderForUser(currUser: ViewController.currentUserLogged)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var postalLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var uIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.layer.borderWidth = 1
        let nib = UINib(nibName: "OrderCartCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "collectionViewID")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ShippingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders[Int(collectionView.tag)].cartInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath as IndexPath) as! OrderCartCollectionViewCell
        let cart = orders[Int(collectionView.tag)].cartInfo
        cell.name.text = cart[indexPath.row].name
        cell.cartImg.image = cart[indexPath.row].image
        cell.price.text = "$"+String(format: "%.2f", cart[indexPath.row].price)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
