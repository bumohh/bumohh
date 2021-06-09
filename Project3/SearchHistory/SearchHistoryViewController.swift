//
//  SearchHistoryViewController.swift
//  Project3
//
//  Created by Bruno Gomez on 6/4/21.
//

import UIKit
import SideMenu

class SearchHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var searchHistory = DatabaseHelper.inst.fetchUserSearchHistory(currUser: ViewController.currentUserLogged)

    @IBOutlet weak var tableView: UITableView!
    var menu : SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = false
        menu?.setNavigationBarHidden(true, animated: false)
        let nib = UINib(nibName: "SearchHistoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SearchHistoryTableViewCell
        cell.name.text = searchHistory[indexPath.row].name
        cell.price.text = "$" + String(searchHistory[indexPath.row].price) + "0"
        let type = searchHistory[indexPath.row].type
        var allTypes = ""
        for data in type {
            allTypes = data

        }
        let gender = searchHistory[indexPath.row].gender
        var allGenders = ""
        for data in gender {
            allGenders = data
        }
        cell.type.text = allTypes
        cell.gender.text = allGenders
        cell.cellImage.image = searchHistory[indexPath.row].image
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func sideMenuButton(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
