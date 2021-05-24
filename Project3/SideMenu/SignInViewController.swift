//
//  SignInViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/22/21.
//

import UIKit
import SideMenu

class SignInViewController: UIViewController {

    var menu : SideMenuNavigationController?
    @IBOutlet weak var storeName: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var exitSearchButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    @IBAction func searchButton(_ sender: Any) {
        self.searchBar.isHidden = false
        self.exitSearchButton.isHidden = false
        self.sideMenuButton.isHidden = true
        self.searchButton.isHidden = true
        self.cartButton.isHidden = true
        self.storeName.isHidden = true
    }
    @IBAction func exitSearchButton(_ sender: Any) {
        self.searchBar.isHidden = true
        self.exitSearchButton.isHidden = true
        self.sideMenuButton.isHidden = false
        self.searchButton.isHidden = false
        self.cartButton.isHidden = false
        self.storeName.isHidden = false
    }
    
    @IBAction func logInButton(_ sender: Any) {
        
        if (emailTextField.text == "" || passwordTextField.text == "") {
            let alert = UIAlertController(title: "Error", message: "Text field for Username and Password must not be blank!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            passwordTextField.text = ""
        }
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let createAccountVC = CreateAccountViewController(nibName: "CreateAccountViewController", bundle: nil)
        self.navigationController?.pushViewController(createAccountVC, animated: true)
        createAccountVC.modalTransitionStyle = .crossDissolve
        createAccountVC.modalPresentationStyle =  .fullScreen
        self.present(createAccountVC, animated: true, completion: nil)
    }
    
}
