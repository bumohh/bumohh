//
//  ShippingInfoViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/22/21.
//

import UIKit
import SideMenu

class ShippingInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var shipTableView: UITableView!
    var menu : SideMenuNavigationController?
    var orders = DatabaseHelper.inst.fetchOrderForUser(currUser: ViewController.currentUserLogged)
    var user = DatabaseHelper.inst.fetchAllUserData()
    var userCart = DatabaseHelper.inst.fetchUserCart(currUser: ViewController.currentUserLogged)
    var arrTotal: [Float] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ShippingTableViewCell", bundle: nil)
        shipTableView.register(nib, forCellReuseIdentifier: "shipCell")
        shipTableView.delegate = self
        shipTableView.dataSource = self
        shipTableView.separatorStyle = .none
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = false
        menu?.setNavigationBarHidden(true, animated: false)
        //SideMenuManager.default.rightMenuNavigationController = menu
        //SideMenuManager.default.addPanGestureToPresent(toView: view)
    }

    @IBAction func homeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(identifier: "Main") as ViewController
        
        mainViewController.modalTransitionStyle = .crossDissolve
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Refund", message: "Currently refunding item with Order ID: \(orders[indexPath.row].uniqueID)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { [self] (action: UIAlertAction!) in
            print("deleting item")
            //call databasehelper .deleteorder here
            print(orders[indexPath.row].cartInfo)
            DatabaseHelper.inst.addRefund(currUser: ViewController.currentUserLogged, shippingInfo: orders[indexPath.row].shippingInfo, cart: orders[indexPath.row].cartInfo, uID: orders[indexPath.row].uniqueID)
            //end addition
            DatabaseHelper.inst.deleteOrder(currUser: ViewController.currentUserLogged, uID: self.orders[indexPath.row].uniqueID, index: indexPath.row, price: arrTotal[indexPath.row])
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shipCell", for: indexPath) as! ShippingTableViewCell
        cell.fullNameLabel.text = orders[indexPath.row].shippingInfo.name
        var total : Float = 0
        for data in orders[indexPath.row].cartInfo {
            total += data.price
        }
        arrTotal.append(total)
        let totalString = String(format: "%.2f", total)
        cell.collectionView.tag = indexPath.row
        cell.totalAmountLabel.text = "$ \(totalString)"
        cell.phoneNumberLabel.text = orders[indexPath.row].shippingInfo.phoneNumber
        cell.cityLabel.text = orders[indexPath.row].shippingInfo.city
        cell.postalLabel.text = orders[indexPath.row].shippingInfo.postalCode
        cell.itemCountLabel.text = String(orders[indexPath.row].cartInfo.count)
        cell.addressLabel.text = orders[indexPath.row].shippingInfo.address
        cell.uIDLabel.text = orders[indexPath.row].uniqueID

//        for o in orders[indexPath.row].cartInfo {
//            print(o)
//            let label: UILabel = UILabel()
//            label.text = "$\(o.price):  \(o.name)"
//            label.textColor = .black
//            label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
//            cell.itemStackView.addArrangedSubview(label)
//            cell.itemStackView.distribution = .fillEqually
        
            //cell.itemNameLabel.text = "Item Name: \(o.name), Price: \(o.price)"
//        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }

}
