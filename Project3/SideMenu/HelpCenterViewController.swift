//
//  HelpCenterViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/22/21.
//

import UIKit
import SideMenu
import SafariServices

class HelpCenterViewController: UIViewController {

    var menu : SideMenuNavigationController?
    
    @IBOutlet var categoryButtons: [UIButton]!
    @IBOutlet var categoryViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorderOnButtons()
        setBordersOnViews()
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = false
        menu?.setNavigationBarHidden(true, animated: false)
        //SideMenuManager.default.rightMenuNavigationController = menu
        //SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    func setBordersOnViews() {
        for v in categoryViews {
            v.layer.cornerRadius = 10.0
            v.layer.masksToBounds = true
        }
    }
    
    func setBorderOnButtons() {
        for b in categoryButtons {
            b.layer.cornerRadius = 10.0
            b.layer.masksToBounds = true
            b.layer.borderWidth = 1.0
            b.layer.borderColor = UIColor.black.cgColor
        }
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
    
    @IBAction func supportButtonClicked(_ sender: Any) {
        let url = URL(string: "https://alphalete.zendesk.com/hc/en-us/requests/new")
        let safariVC = SFSafariViewController(url: url!)
        present(safariVC, animated: true, completion: nil)
    }
    
    enum category: String {
        case returnsAndExchanges = "Returns & Exchanges"
        case paymentsAndDiscounts = "Payments & Discounts"
        case shippingAndDelivery = "Shipping & Delivery"
        case generalInformation = "General Information"
    }
    
    func toggleHiddenPropertyOnViews(tag: Int) {
        for c in categoryViews {
            if (c.tag == tag) {
                c.isHidden = false
            }
            else {
                c.isHidden = true
            }
        }
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let c = category(rawValue: title) else {
            return
        }
        
        switch c {
        case .returnsAndExchanges:
            print("Clicked Return & Exhange")
            toggleHiddenPropertyOnViews(tag: 1)
        case .paymentsAndDiscounts:
            print("Clicked Payments & Discounts")
            toggleHiddenPropertyOnViews(tag: 2)
        case .shippingAndDelivery:
            print("Clicked Shipping & Delivery")
            toggleHiddenPropertyOnViews(tag: 3)
        case .generalInformation:
            print("Clicked General Information")
            toggleHiddenPropertyOnViews(tag: 4)
        default:
            print("Default Case")
        }
        
    }
    
    
}
