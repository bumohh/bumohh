//
//  SignInViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/22/21.
//

import UIKit
import SideMenu
protocol SignInViewControllerDelegate : AnyObject {
    func signInSuccess()
}
class SignInViewController: UIViewController {

    var menu : SideMenuNavigationController?
    @IBOutlet weak var storeName: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinView: UIView!
    @IBOutlet weak var signinButton: UIButton!
    var signInSuccess : Bool = false
    weak var delegate : SignInViewControllerDelegate?
    //static var currentUserLogged: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewBorders()
        setupButtonBorders()
        setupTextFieldBorders()
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = false
        menu?.setNavigationBarHidden(true, animated: false)
        //SideMenuManager.default.rightMenuNavigationController = menu
        //SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    func setupViewBorders() {
        signinView.layer.cornerRadius = 10.0
        signinView.layer.masksToBounds = true
    }
    
    func setupButtonBorders() {
        signinButton.layer.cornerRadius = 18.0
        signinButton.layer.masksToBounds = true
        signinButton.layer.borderColor = UIColor.black.cgColor
        signinButton.layer.borderWidth = 1.0
    }
    
    func setupTextFieldBorders() {
        //Email Text Field
        emailTextField.layer.cornerRadius = 18.0
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderWidth = 1.0
        //Password Text Field
        passwordTextField.layer.cornerRadius = 18.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 1.0
    }

    @IBAction func homeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(identifier: "Main") as ViewController
        mainViewController.modalTransitionStyle = .crossDissolve
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    @IBAction func logInButton(_ sender: Any) {
        let customerData = DatabaseHelper.inst.fetchAllUserData()
        
        for c in customerData {
            if (emailTextField.text == "" || passwordTextField.text == "") {
                let alert = UIAlertController(title: "Error", message: "Text field for Email and Password must not be blank!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passwordTextField.text = ""
            }
            if (c.username == emailTextField.text && c.password == passwordTextField.text) {
                ViewController.currentUserLogged = c.username!
                emailTextField.text = ""
                passwordTextField.text = ""
                signInSuccess = true
                print("Sign In Successful")
                for data in ViewController.GuestCart {
                    print("merging cart")
                    DatabaseHelper.inst.addToCart(obj: data, currUser: ViewController.currentUserLogged)
                }
                for data in ViewController.GuestSearchHistory {
                    print("merging history")
                    DatabaseHelper.inst.addToSearchHistory(obj: data, currUser: ViewController.currentUserLogged)
                }
                ViewController.GuestCart.removeAll()
                ViewController.GuestSearchHistory.removeAll()
                break
            }
            else {
                print("Sign In Unsuccessful")
            }
        }
        if (signInSuccess) {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainViewController = storyboard.instantiateViewController(identifier: "Main") as ViewController
//            mainViewController.modalTransitionStyle = .crossDissolve
//            mainViewController.modalPresentationStyle = .fullScreen
//            self.present(mainViewController, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            self.delegate?.signInSuccess()
            
        }
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let createAccountVC = CreateAccountViewController(nibName: "CreateAccountViewController", bundle: nil)
        self.navigationController?.pushViewController(createAccountVC, animated: true)
        createAccountVC.modalTransitionStyle = .crossDissolve
        createAccountVC.modalPresentationStyle =  .fullScreen
        self.present(createAccountVC, animated: true, completion: nil)
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        let forgotPassVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(forgotPassVC, animated: true)
        forgotPassVC.modalTransitionStyle = .crossDissolve
        forgotPassVC.modalPresentationStyle =  .fullScreen
        self.present(forgotPassVC, animated: true, completion: nil)
    }
    
    
    @IBAction func goPaymentOptionTest(_ sender: Any) {
        let paymentVC = PaymentViewController(nibName: "PaymentViewController", bundle: nil)
        self.navigationController?.pushViewController(paymentVC, animated: true)
        paymentVC.modalTransitionStyle = .crossDissolve
        paymentVC.modalPresentationStyle =  .fullScreen
        self.present(paymentVC, animated: true, completion: nil)
    }
}
