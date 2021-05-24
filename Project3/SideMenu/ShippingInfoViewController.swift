//
//  ShippingInfoViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/22/21.
//

import UIKit
import SideMenu

class ShippingInfoViewController: UIViewController {

    var menu : SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
