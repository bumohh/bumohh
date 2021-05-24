//
//  CreateAccountViewController.swift
//  Project3
//
//  Created by Edward Guilllermo on 5/24/21.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    let customerData = DatabaseHelper.inst.fetchAllUserData()
    var signUpSuccess : Bool = false
    var isUnique : Bool = false
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonBorders()
        setupTextFieldBorders()
    }
    
    func setupButtonBorders() {
        createAccountButton.layer.cornerRadius = 10.0
        createAccountButton.layer.masksToBounds = true
        createAccountButton.layer.borderColor = UIColor.white.cgColor
        createAccountButton.layer.borderWidth = 1.0
    }
    
    func setupTextFieldBorders() {
        //Email Border
        emailTextField.layer.cornerRadius = 10.0
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderWidth = 1.0
        //Mobile Border
        mobileTextField.layer.cornerRadius = 10.0
        mobileTextField.layer.masksToBounds = true
        mobileTextField.layer.borderColor = UIColor.black.cgColor
        mobileTextField.layer.borderWidth = 1.0
        //Password Border
        passTextField.layer.cornerRadius = 10.0
        passTextField.layer.masksToBounds = true
        passTextField.layer.borderColor = UIColor.black.cgColor
        passTextField.layer.borderWidth = 1.0
    }
    
    
    @IBAction func signInButton(_ sender: Any) {
        let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
        self.navigationController?.pushViewController(signInVC, animated: true)
        signInVC.modalTransitionStyle = .crossDissolve
        signInVC.modalPresentationStyle = .fullScreen
        self.present(signInVC, animated: true, completion: nil)
    }

    @IBAction func createAccountButton(_ sender: Any) {
        if (customerData.isEmpty) {
            isUnique = validateInputs(customerData: customerData)
            if (isUnique) {
                let dict = ["username" : emailTextField.text, "password" : passTextField.text]
                DatabaseHelper.inst.saveNewUser(object: dict as! [String : String], number: mobileTextField.text!)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                signUpSuccess = true
            }
            if (signUpSuccess) {
                let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
                self.navigationController?.pushViewController(signInVC, animated: true)
                signInVC.modalTransitionStyle = .crossDissolve
                signInVC.modalPresentationStyle = .fullScreen
                self.present(signInVC, animated: true, completion: nil)
            }
        }
        
        for c in customerData {
            isUnique = validateInputs(customerData: customerData)
            if ((index == customerData.count - 1) && isUnique) {
                let dict = ["username" : emailTextField.text, "password" : passTextField.text]
                DatabaseHelper.inst.saveNewUser(object: dict as! [String : String], number: mobileTextField.text!)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                signUpSuccess = true
                break
            }
            index += 1
        }
        if (signUpSuccess) {
            let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
            self.navigationController?.pushViewController(signInVC, animated: true)
            signInVC.modalTransitionStyle = .crossDissolve
            signInVC.modalPresentationStyle = .fullScreen
            self.present(signInVC, animated: true, completion: nil)
        }
    }
    
    func validateInputs(customerData: [Users]) -> Bool {
        if (customerData.isEmpty) {
            return emptyCustomerDataValidation()
        }
        
        for c in customerData {
            if (emailTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || passTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || mobileTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty) {
                let alert = UIAlertController(title: "Error", message: "Text field for Email, Password, and Mobile Number must not be blank!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                return false
            }
            if (c.username == emailTextField.text) {
                let alert = UIAlertController(title: "Error", message: "Email taken, please input another name for your email!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                return false
            }
            if (emailTextField.text!.count < 4) {
                let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed for your email!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                return false
            }
            if (emailTextField.text!.count > 12) {
                let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed for your email!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                return false
            }
            if (passTextField.text!.count < 4) {
                let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                return false
            }
            if (passTextField.text!.count > 12) {
                let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 character allowed in a password!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                return false
            }
            if (mobileTextField.text!.count != 10) {
                let alert = UIAlertController(title: "Error", message: "Mobile Number must be 10 numbers!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                return false
            }
        }
        return true
    }
    
    func emptyCustomerDataValidation() -> Bool {
        if (emailTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || passTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || mobileTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty) {
            let alert = UIAlertController(title: "Error", message: "Text field for Email, Password, and Mobile Number must not be blank!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            passTextField.text = ""
            mobileTextField.text = ""
            return false
        }
        if (emailTextField.text!.count < 4) {
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed for your email!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            passTextField.text = ""
            mobileTextField.text = ""
            return false
        }
        if (emailTextField.text!.count > 12) {
            let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed for your email!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            passTextField.text = ""
            return false
        }
        if (passTextField.text!.count < 4) {
            let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            passTextField.text = ""
            mobileTextField.text = ""
            return false
        }
        if (passTextField.text!.count > 12) {
            let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 character allowed in a password!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            passTextField.text = ""
            mobileTextField.text = ""
            return false
        }
        if (mobileTextField.text!.count != 10) {
            let alert = UIAlertController(title: "Error", message: "Mobile Number must be 10 numbers!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            emailTextField.text = ""
            passTextField.text = ""
            mobileTextField.text = ""
            return false
        }
        return true
    }
}

