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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ShippingTableViewCell", bundle: nil)
        shipTableView.register(nib, forCellReuseIdentifier: "shipCell")
        shipTableView.delegate = self
        shipTableView.dataSource = self
        
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
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action: UIAlertAction!) in
            print("deleting item")
            //call databasehelper .deleteorder here
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shipCell", for: indexPath) as! ShippingTableViewCell
        cell.fullNameLabel.text = orders[indexPath.row].shippingInfo.name
        
        let order = DatabaseHelper.inst.fetchOrderForUser(currUser: ViewController.currentUserLogged)[indexPath.row]
        var total : Float = 0
        for data in order.cartInfo {
            total += data.price
        }
        let totalString = String(format: "%.2f", total)
        cell.totalAmountLabel.text = "$ \(totalString)"
        cell.phoneNumberLabel.text = order.shippingInfo.phoneNumber
        cell.cityLabel.text = order.shippingInfo.city
        cell.postalLabel.text = order.shippingInfo.postalCode
        cell.itemCountLabel.text = String(order.cartInfo.count)
        cell.addressLabel.text = order.shippingInfo.address
        cell.uIDLabel.text = order.uniqueID
        //call subviewfunction
        /*
        for u in user {
            if (u.username == ViewController.currentUserLogged) {
                for item in u.cart?.count! {
                    let label: UILabel = UILabel()
                    label.text = item.name
                    label.textColor = .black
                    cell.itemStackView.addArrangedSubview(label)
                }
            }
        }
         */
        for o in order.cartInfo {
            print(o)
            let label: UILabel = UILabel()
            label.text = "$\(o.price):  \(o.name)"
            label.textColor = .black
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
            cell.itemStackView.addArrangedSubview(label)
            cell.itemStackView.distribution = .fillEqually
            //cell.itemNameLabel.text = "Item Name: \(o.name), Price: \(o.price)"
        }
        return cell
    }
    
    /*
    func configureStackView(cell: ShippingTableViewCell) {
        view.addSubview(cell.cartStackView)
        cell.cartStackView.translatesAutoresizingMaskIntoConstraints = false
        cell.cartStackView.topAnchor.constraint(equalTo: cell.itemCountLabel.bottomAnchor, constant: 20).isActive = true
        cell.cartStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        cell.cartStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        cell.cartStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
     */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }

}
