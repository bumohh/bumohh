//
//  CartViewController.swift
//  Project3
//
//  Created by Tommy Phan on 6/2/21.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    var cart = DatabaseHelper.inst.fetchUserCart(currUser: ViewController.currentUserLogged)
    
    @IBOutlet weak var total: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartButton.isHidden = true
        searchButton.isHidden = true
        menuButton.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        updateTotal()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            DatabaseHelper.inst.removeFromCart(obj: cart[indexPath.row], currUser: ViewController.currentUserLogged)
            cart.remove(at: indexPath.row)
            tableView.reloadData()
            updateTotal()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableViewCell
        cell.name.text = cart[indexPath.row].name
        cell.cellImage.image = cart[indexPath.row].image
        cell.price.text = "$" + String(cart[indexPath.row].price) + "0"
        return cell
    }
    func updateTotal() {
        var val : Float = 0
        for data in cart {
            val += data.price
            print(data.price)
        }
        self.total.text = "$" + String(format: "%.2f", val)
    }
    @IBAction func alphalete(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkoutButton(_ sender: Any) {
        let snbVC = ShippingBillingViewController(nibName: "ShippingBillingViewController", bundle: nil)
        self.navigationController?.pushViewController(snbVC, animated: true)
        snbVC.modalTransitionStyle = .crossDissolve
        snbVC.modalPresentationStyle = .fullScreen
        self.present(snbVC, animated: true, completion: nil)
    }
    
}
