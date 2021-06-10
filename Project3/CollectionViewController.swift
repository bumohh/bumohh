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
    var queryArray : [String] = []
    var dropButton = DropDown()
    var passedQuery : [String] = []
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var layoutButton: UISwitch!
    @IBOutlet weak var exitSearchBar: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sideMenu: UIButton!
    @IBOutlet weak var storeName: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var sideMenuButton: UIButton!
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
        storeName.isHidden = true
        searchButton.isHidden = true
        cartButton.isHidden = true
        sideMenuButton.isHidden = true
        
        if ViewController.search {
            searchBar.becomeFirstResponder()
            collectionView.reloadData()
        } else {
            if SideMenuTableViewController.newQuery.count == 0 {
                let query = DatabaseHelper.inst.fetchManyFilteredClothes(query: self.passedQuery)
                collectionView.reloadData()
                
                updateCollection(query: query)
                
                ViewController.search = true
            } else {
                collectionView.reloadData()
                print(queryArray)
                let query = DatabaseHelper.inst.fetchManyFilteredClothes(query: queryArray)
                updateCollection(query: query)
                SideMenuTableViewController.newQuery = []
                ViewController.search = true
            }
        }
        searchDataFiltered = searchData
        dropButton.anchorView = searchBar
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        dropButton.backgroundColor = .white
        dropButton.direction = .bottom
        
        dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            deleteCollection()
            queryArray.append(item)
            categoryCollectionView.reloadData()
            let query = DatabaseHelper.inst.fetchManyFilteredClothes(query: queryArray)
            updateCollection(query: query)
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
        categoryCollectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    func updateCollection(query : [ClothingObj]) {
        for data in query {
            self.itemPriceData.append(String(format: "%.2f", data.price))
            self.itemColorData.append(String(data.color))
            self.itemNameData.append(data.name)
            self.imageData.append(data.image)
            self.idData.append(data.id)
            collectionView.reloadData()
        }
    }
    
    func deleteCollection() {
        self.itemPriceData.removeAll()
        self.itemColorData.removeAll()
        self.itemNameData.removeAll()
        self.imageData.removeAll()
        self.idData.removeAll()
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchData.contains(searchBar.text!) {
            queryArray.append(searchBar.text!)
            categoryCollectionView.reloadData()
            print("added to query array")
            deleteCollection()
            let query = DatabaseHelper.inst.fetchManyFilteredClothes(query: queryArray)
            updateCollection(query: query)
            dropDown.hide()
        } else {
            print("not a valid option")
        }
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
    //passing data to itemviewcontroller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            print("you tapped category ", indexPath.row)
        } else {
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
    
}

extension CollectionViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return queryArray.count
        } else {
            return imageData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let categoryCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            categoryCell.sizeToFit()
            categoryCell.category.text = queryArray[indexPath.row]
            
            return categoryCell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
            
            for i in indexPath {
                cell.configureImage(with: imageData[i])
                cell.configureItemName(with: itemNameData[i])
                cell.configureItemColor(with: itemColorData[i] + " Colors")
                cell.configureItemPrice(with:  "$" + itemPriceData[i])
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "error", for: indexPath)
            return cell
        }
        
    }
    
    
    
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 200, height: 390)
        } else {
            return CGSize(width: (collectionView.frame.width / CGFloat(queryArray.count)) - 5, height: (collectionView.frame.height / CGFloat(queryArray.count)-5))
        }
    }
}
