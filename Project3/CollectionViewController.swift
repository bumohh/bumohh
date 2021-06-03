//
//  CollectionViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/26/21.
//

import UIKit
import DropDown

class CollectionViewController: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    let defaults = UserDefaults.standard
    let searchData = DatabaseHelper.inst.categories
    var searchDataFiltered : [String] = []
    var dropButton = DropDown()

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var layoutButton: UISwitch!
    @IBOutlet weak var exitSearchBar: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sideMenu: UIButton!
    let dropDown = DropDown()
    var imageData: [UIImage] = []
    
    var itemNameData: [String] = []
    
    var itemColorData: [String] = []
    
    var itemPriceData: [String] = []
    var idData : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.isHidden = false
        exitSearchBar.isHidden = false
        searchBar.becomeFirstResponder()
        searchDataFiltered = searchData
        dropButton.anchorView = searchBar
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        dropButton.backgroundColor = .white
        dropButton.direction = .bottom
        dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            searchBar.text = item
            self.itemPriceData.removeAll()
            self.itemColorData.removeAll()
            self.itemNameData.removeAll()
            self.imageData.removeAll()
            self.idData.removeAll()
            let query = DatabaseHelper.inst.fetchFilteredClothes(query: self.searchBar.text!)
            for data in query {
                self.itemPriceData.append(String(format: "%.2f", data.price))
                self.itemColorData.append(String(data.color))
                self.itemNameData.append(data.name)
                self.imageData.append(data.image)
                self.idData.append(data.id)
                collectionView.reloadData()
            }
            if query.count == 0 {
                self.itemPriceData.removeAll()
                self.itemColorData.removeAll()
                self.itemNameData.removeAll()
                self.imageData.removeAll()
                self.idData.removeAll()
                collectionView.reloadData()
            }
            
        }
        dropDown.cancelAction = { [unowned self] in
            for data in searchData {
                if searchBar.text == data {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("dismiss")
                }
            }
        }
        
        searchBar.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 50.0, left: 2.0, bottom: 1.0, right: 2.0)
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: 200, height: 410)
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        dropButton.dataSource = searchData
        dropButton.show()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDataFiltered = searchText.isEmpty ? searchData : searchData.filter({ (dat) -> Bool in
                dat.range(of: searchText, options: .caseInsensitive) !=
                nil
            })

        dropButton.dataSource = searchDataFiltered
        dropButton.show()
        
        let query = DatabaseHelper.inst.fetchFilteredClothes(query: self.searchBar.text!)
        for data in query {
            self.itemPriceData.append(String(format: "%.2f", data.price))
            self.itemColorData.append(String(data.color))
            self.itemNameData.append(data.name)
            self.imageData.append(data.image)
            self.idData.append(data.id)
            collectionView.reloadData()
        }
        if query.count == 0 {
            self.itemPriceData.removeAll()
            self.itemColorData.removeAll()
            self.itemNameData.removeAll()
            self.imageData.removeAll()
            self.idData.removeAll()
            collectionView.reloadData()
        }
    }
    
    @IBAction func searchButton(_ send: Any) {
        self.searchBar.isHidden = false
        self.exitSearchBar.isHidden = false
        self.sideMenu.isHidden = true
    }
    
    @IBAction func exitSearchButton(_ sender: Any) {
        self.searchBar.isHidden = true
        self.exitSearchBar.isHidden = true
        self.sideMenu.isHidden = true
        searchDataFiltered = searchData
        dropButton.hide()
        self.dismiss(animated: true)
    }
    
    @IBAction func layoutButton(_ sender: Any) {
        
        if layoutButton.isOn == false {
            
            let layout = UICollectionViewFlowLayout()
            collectionView.collectionViewLayout = layout
            layout.itemSize = CGSize(width: 210, height: 410)
            collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        } else {
            let layout = UICollectionViewFlowLayout()
            collectionView.collectionViewLayout = layout
            layout.itemSize = CGSize(width: 200, height: 410)
            collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        }
        
    }
    @IBAction func alphalete(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension CollectionViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("you tapped item number \((indexPath.row)+1)")
        print(idData)
        defaults.setValue(idData[indexPath.row], forKey: "passedID")
        let vc = ItemViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
        //present next view
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
            cell.configureItemPrice(with:  "$" + itemPriceData[i])
        }
        
        return cell
    }
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 390)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
}
