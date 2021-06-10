//
//  WishListViewController.swift
//  Project3
//
//  Created by Bruno Gomez on 6/3/21.
//

import UIKit
import SideMenu

class WishListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var wishList = DatabaseHelper.inst.fetchUserWishList(currUser: ViewController.currentUserLogged) //return wishlist from DBHelper for currUser
    @IBOutlet weak var tableView: UITableView!
    var menu : SideMenuNavigationController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            DatabaseHelper.inst.removeFromWishList(obj: wishList[indexPath.row], currUser: ViewController.currentUserLogged )
            wishList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WishListTableViewCell
        cell.name.text = wishList[indexPath.row].name
        cell.cellImage.image = wishList[indexPath.row].image
        cell.price.text = "$" + String(wishList[indexPath.row].price) + "0"
        let type = wishList[indexPath.row].type
        var allTypes = ""
        for data in type {
            allTypes = data

        }
        let gender = wishList[indexPath.row].gender
        var allGenders = ""
        for data in gender {
            allGenders = data
        }
        cell.type.text = allTypes
        cell.gender.text = allGenders
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = false
        menu?.setNavigationBarHidden(true, animated: false)
        let nib = UINib(nibName: "WishListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func sideMenuButton(_ sender: Any) {
        present(menu!, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
