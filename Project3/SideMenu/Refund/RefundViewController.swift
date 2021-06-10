//
//  RefundViewController.swift
//  Project3
//
//  Created by Edward Guilllermo on 6/8/21.
//

import UIKit
import SideMenu

class RefundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var menu : SideMenuNavigationController?
    
    @IBOutlet weak var refundLabel: UILabel!
    @IBOutlet weak var refundTableView: UITableView!
    var orders = DatabaseHelper.inst.fetchOrderForUser(currUser: ViewController.currentUserLogged)
    var user = DatabaseHelper.inst.fetchAllUserData()
    let refund = DatabaseHelper.inst.fetchRefundForUser(currUser: ViewController.currentUserLogged)
    //var total : Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = false
        menu?.setNavigationBarHidden(true, animated: false)
        
        let nib = UINib(nibName: "RefundTableViewCell", bundle: nil)
        refundTableView.register(nib, forCellReuseIdentifier: "refundCell")
        refundTableView.delegate = self
        refundTableView.dataSource = self
        setRefundLabel()
    }
    
    func setRefundLabel() {
        for u in user {
            if u.username == ViewController.currentUserLogged {
                refundLabel.text = String(format: "%.2f", u.balance)
            }
        }
    }

    //MARK:- Table Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refund.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "refundCell", for: indexPath) as! RefundTableViewCell
        cell.nameLabel.text = refund[indexPath.row].shippingInfo.name
        
        let refund = DatabaseHelper.inst.fetchRefundForUser(currUser: ViewController.currentUserLogged)[indexPath.row]

        var total : Float = 0
        for data in refund.cartInfo {
            total += data.price
        }
        let totalString = String(format: "%.02f", total)
        cell.totalLabel.text = "$ \(totalString)"
        cell.phoneLabel.text = refund.shippingInfo.phoneNumber
        cell.cityLabel.text = refund.shippingInfo.city
        cell.postalLabel.text = refund.shippingInfo.postalCode
        cell.itemCountLabel.text = String(refund.cartInfo.count)
        cell.orderIDLabel.text = refund.uniqueID
        
        for o in refund.cartInfo {
            print(o)
            let label: UILabel = UILabel()
            label.text = "$\(o.price)0:  \(o.name)"
            label.textColor = .black
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
            cell.itemStackView.addArrangedSubview(label)
            cell.itemStackView.distribution = .fillEqually
            cell.itemStackView.layer.borderWidth = 1
            cell.itemStackView.layer.cornerRadius = 5
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sideMenuButton(_ sender: Any) {
        present(menu!, animated: true)
    }
    
}
