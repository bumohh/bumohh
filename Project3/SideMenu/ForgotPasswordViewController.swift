//
//  ForgotPasswordViewController.swift
//  Project3
//
//  Created by Edward Guilllermo on 5/24/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var repPassTextField: UITextField!
    @IBOutlet weak var forgotImage: UIImageView!
    @IBOutlet weak var forgotView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    var resetSuccess : Bool = false
    var checkUser : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonBorders()
        setupTextFieldBorders()
        setupImageAndViewBorders()
    }
    
    func setupImageAndViewBorders() {
        forgotImage.layer.cornerRadius = 10.0
        forgotImage.layer.masksToBounds = true
        forgotView.layer.cornerRadius = 10.0
        forgotView.layer.masksToBounds = true
    }
    
    func setupButtonBorders() {
        resetButton.layer.cornerRadius = 10.0
        resetButton.layer.masksToBounds = true
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.layer.borderWidth = 1.0
    }
    
    func setupTextFieldBorders() {
        //Email Border
        emailTextField.layer.cornerRadius = 10.0
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderWidth = 1.0
        //Mobile Border
        newPassTextField.layer.cornerRadius = 10.0
        newPassTextField.layer.masksToBounds = true
        newPassTextField.layer.borderColor = UIColor.black.cgColor
        newPassTextField.layer.borderWidth = 1.0
        //Password Border
        repPassTextField.layer.cornerRadius = 10.0
        repPassTextField.layer.masksToBounds = true
        repPassTextField.layer.borderColor = UIColor.black.cgColor
        repPassTextField.layer.borderWidth = 1.0
    }

    @IBAction func resetButton(_ sender: Any) {
        let customerData = DatabaseHelper.inst.fetchAllUserData()
        var validInput: Bool
        
        for c in customerData {
            validInput = validateInputs()
            if (c.username == emailTextField.text && validInput) {
                if (newPassTextField.text == repPassTextField.text) {
                    let dict = ["username" : emailTextField.text, "password" : newPassTextField.text]
                    DatabaseHelper.inst.updateUserPassword(object: dict as! [String : String])
                    emailTextField.text = ""
                    newPassTextField.text = ""
                    repPassTextField.text = ""
                    resetSuccess = true
                    checkUser = true
                    break
                }
            }
        }
        if (checkUser == false) {
            let alert = UIAlertController(title: "Error", message: "No such Username found!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            newPassTextField.text = ""
            repPassTextField.text = ""
        }
        if (resetSuccess) {
            let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
            self.navigationController?.pushViewController(signInVC, animated: true)
            signInVC.modalTransitionStyle = .crossDissolve
            signInVC.modalPresentationStyle = .fullScreen
            self.present(signInVC, animated: true, completion: nil)
        }
    }
    
    func validateInputs() -> Bool {
        if (emailTextField.text == "" || newPassTextField.text == "" ||
                repPassTextField.text == "") {
            let alert = UIAlertController(title: "Error", message: "Text field for Username, New Password, and repeat password must not be blank!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            newPassTextField.text = ""
            repPassTextField.text = ""
            return false
        }
        if (newPassTextField.text != repPassTextField.text) {
            let alert = UIAlertController(title: "Error", message: "New password and Repeat password text field not the same!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            newPassTextField.text = ""
            repPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count < 4) {
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            newPassTextField.text = ""
            repPassTextField.text = ""
            return false
        }
        if (newPassTextField.text!.count > 12) {
            let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            newPassTextField.text = ""
            repPassTextField.text = ""
            return false
        }
        if (repPassTextField.text!.count < 4) {
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            newPassTextField.text = ""
            repPassTextField.text = ""
            return false
        }
        if (repPassTextField.text!.count > 12) {
            let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            newPassTextField.text = ""
            repPassTextField.text = ""
            return false
        }
        return true
    }
    
    @IBAction func returnSignInButton(_ sender: Any) {
        let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
        self.navigationController?.pushViewController(signInVC, animated: true)
        signInVC.modalTransitionStyle = .crossDissolve
        signInVC.modalPresentationStyle = .fullScreen
        self.present(signInVC, animated: true, completion: nil)
    }
}
