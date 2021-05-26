//
//  CollectionViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/26/21.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    let imageData: [UIImage] = [UIImage(named: "1")!,
                                UIImage(named: "2")!,
                                UIImage(named: "3")!,
                                UIImage(named: "4")!,
                                UIImage(named: "5")!,
                                UIImage(named: "6")!,
                                UIImage(named: "7")!,
                                UIImage(named: "8")!,
                                UIImage(named: "9")!,
                                UIImage(named: "10")!
                                ]
    
    let itemNameData: [String] = ["Union Short Sleeve",
                                  "Core Cutoff",
                                  "Washed Core Jogger",
                                  "Identity Pro Track Jacket",
                                  "Identity Pro Track Pant",
                                  "Alphalete 3/4 Sleeve",
                                  "Identity Pro Hoodie",
                                  "Identity Pro Short",
                                  "Core Jogger",
                                  "Washed Core Short"
                                  ]
    
    let itemColorData: [String] = ["Grey",
                                  "Light Grey",
                                  "Camo Grey",
                                  "Midnight",
                                  "Midnight",
                                  "Black/Grey",
                                  "White",
                                  "Ivory",
                                  "Blossom",
                                  "Black Camo"
                                  ]
    
    let itemPriceData: [String] = ["$28.00",
                                  "$28.00",
                                  "$58.00",
                                  "$74.00",
                                  "$70.00",
                                  "$32.00",
                                  "$70.00",
                                  "$56.00",
                                  "$56.00",
                                  "$46.00"
                                  ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 50.0, left: 2.0, bottom: 1.0, right: 2.0)
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: 200, height: 410)
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension CollectionViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("you tapped item number \((indexPath.row)+1)")
    }
    
}

extension CollectionViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        for i in indexPath {
            cell.configureImage(with: imageData[i])
            cell.configureItemName(with: itemNameData[i])
            cell.configureItemColor(with: itemColorData[i])
            cell.configureItemPrice(with: itemPriceData[i])
        }
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 390)
    }
    
}
