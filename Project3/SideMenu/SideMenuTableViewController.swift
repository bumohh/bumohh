//
//  SideMenyTableViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/22/21.
//

import UIKit
import DropDown

class SideMenuTableViewController: UITableViewController {
    var textData = ["Men","Women","Last Chance"]
    var textDataTwo = ["Sign In","Search History","Help Center"] //removed Shipping Info
    var recentlyAddedSection: Bool = false
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserCurrentlyLoggedIn()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    func setupUserCurrentlyLoggedIn() {
        if (ViewController.currentUserLogged != "Guest") {
            textDataTwo[0] = "Welcome \(ViewController.currentUserLogged)"
            textDataTwo.append("My Orders")
            textDataTwo.append("Wishlist")
            textDataTwo.append("Log Out")
            recentlyAddedSection = true
        }
        else {
            textDataTwo[0] = "Sign In"
            if (recentlyAddedSection) {
                textDataTwo.removeSubrange(ClosedRange(uncheckedBounds: (lower: 2, upper: 3)))
                recentlyAddedSection = false
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch  section {
        case 0:
            return textData.count
        case 1:
            return textDataTwo.count
        default:
            return 0
        }
        
        //return textData.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = textData[indexPath.row]
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        case 1:
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
            cell.textLabel?.text = textDataTwo[indexPath.row]
        default:
            print("")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        dropDown.textFont = UIFont(name: "HelveticaNeue-Bold", size: 15.0)!
        
        switch indexPath.section {
        case 0:
            switch textData[indexPath.row] {
            case "Men":
                
                if let cell = tableView.cellForRow(at: indexPath) {
                      dropDown.dataSource = ["Shop All", "New Arrivals", "Shirts & Tops", "Bottoms", "Tanks & Stringers", "Hoodies & Jackets", "Underwear", "Accessories", "LAST CHANCE", "Gift Card"]
                      dropDown.anchorView = cell
                      dropDown.bottomOffset = CGPoint(x: 0, y: cell.frame.size.height)
                      dropDown.backgroundColor = .white
                      dropDown.show()
                      dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                        guard let _ = self else { return }
                      }
                    }
                
//                let vc = MenViewController()
//                vc.modalTransitionStyle = .crossDissolve
//                vc.modalPresentationStyle =  .fullScreen
//                self.present(vc, animated: true, completion: nil)
//                print("Men")
                
            case "Women":
                
                if let cell = tableView.cellForRow(at: indexPath) {
                      dropDown.dataSource = ["Shop All", "New Arrivals", "Sports Bras", "Leggings", "Joggers", "Shirts & Tops", "Hoodies & Jackets", "Shorts", "Underwear", "Accessories", "LAST CHANCE", "Gift Card"]
                      dropDown.anchorView = cell
                      dropDown.bottomOffset = CGPoint(x: 0, y: cell.frame.size.height)
                      dropDown.backgroundColor = .white
                      dropDown.show()
                      dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                        guard let _ = self else { return }
                      }
                    }
                
//                let vc = WomenViewController()
//                vc.modalTransitionStyle = .crossDissolve
//                vc.modalPresentationStyle =  .fullScreen
//                self.present(vc, animated: true, completion: nil)
//                print("Women")
            case "Last Chance":
                
                if let cell = tableView.cellForRow(at: indexPath) {
                      dropDown.dataSource = ["Men's", "Women's"]
                      dropDown.anchorView = cell
                      dropDown.bottomOffset = CGPoint(x: 0, y: cell.frame.size.height)
                      dropDown.backgroundColor = .white
                      dropDown.show()
                      dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                        guard let _ = self else { return }
                      }
                    }
                
//                let vc = LastChanceViewController()
//                vc.modalTransitionStyle = .crossDissolve
//                vc.modalPresentationStyle =  .fullScreen
//                self.present(vc, animated: true, completion: nil)
//                print("Last Chance")
            default:
                print("section 1 default")
            }
        case 1:
            switch textDataTwo[indexPath.row] {
            case "Sign In":
                
                let vc = SignInViewController()
                vc.delegate = self
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle =  .fullScreen
                self.present(vc, animated: true, completion: nil)
                print("Sign in")
            case "Help Center":
                
                let vc = HelpCenterViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle =  .fullScreen
                self.present(vc, animated: true, completion: nil)
                print("Help Center")
            case "Wishlist":
                
                let vc = WishListViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle =  .fullScreen
                self.present(vc, animated: true, completion: nil)
                print("Wishlist")
            case "My Orders":
                
                let vc = ShippingInfoViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle =  .fullScreen
                self.present(vc, animated: true, completion: nil)
                print("Shipping Info")
                
            case "Search History" :
                let vc = SearchHistoryViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle =  .fullScreen
                self.present(vc, animated: true, completion: nil)
                print("Search History")
                
            case "Log Out":
                ViewController.currentUserLogged = "Guest"
                print("Signed Out, Currently Logged In as Guest")
                textDataTwo = ["Sign In","Help Center"]
                tableView.reloadData()
                /*
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyboard.instantiateViewController(identifier: "Main") as ViewController
                
                mainViewController.modalTransitionStyle = .crossDissolve
                mainViewController.modalPresentationStyle = .fullScreen
                self.present(mainViewController, animated: true, completion: nil)
 */
                self.dismiss(animated: true)
            default:
                print("section 2 default")
        }
        
        default:
            print("default")
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SideMenuTableViewController : SignInViewControllerDelegate {
    func signInSuccess() {
        setupUserCurrentlyLoggedIn()
        tableView.reloadData()
    }
    
    
}
