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
    var shippingInfo = DatabaseHelper.inst.fetchShippingInfo(currUser: ViewController.currentUserLogged)
    var cart = DatabaseHelper.inst.fetchUserCart(currUser: ViewController.currentUserLogged)
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
        return shippingInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shipCell", for: indexPath) as! ShippingTableViewCell
        cell.fullNameLabel.text = shippingInfo[indexPath.row].name
        cell.totalAmountLabel.text = "$ \(shippingInfo[indexPath.row].total)"
        cell.phoneNumberLabel.text = shippingInfo[indexPath.row].phoneNumber
        cell.cityLabel.text = shippingInfo[indexPath.row].city
        cell.postalLabel.text = shippingInfo[indexPath.row].postalCode
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
        cell.itemNameLabel.text = cart[indexPath.row].name
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
