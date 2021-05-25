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
    let customerData = DatabaseHelper.inst.fetchAllUserData()
    var signUpSuccess : Bool = false
    var isUnique : Bool = false
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                //let signInVC = SignInViewController()
                //self.present(signInVC, animated: true, completion: nil)
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
            //let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
            //self.present(signInVC, animated: true, completion: nil)
        }
    }
    @IBAction func returnToStore(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(identifier: "Main") as ViewController
        
        mainViewController.modalTransitionStyle = .crossDissolve
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true, completion: nil)
        
    }
    
    func validateInputs(customerData: [Users]) -> Bool {
        
        for c in customerData {
            if (emailTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || passTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty) {
                let alert = UIAlertController(title: "Error", message: "Text field for Username and Password must not be blank!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                return false
            }
            if (c.username == emailTextField.text) {
                let alert = UIAlertController(title: "Error", message: "Username taken, please input another username!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                return false
            }
            if (emailTextField.text!.count < 4) {
                let alert = UIAlertController(title: "Error", message: "Less than 4 characters, minimum of 4 and maximum of 12 characters allowed in a username!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                mobileTextField.text = ""
                return false
            }
            if (emailTextField.text!.count > 12) {
                let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 characters allowed in a username!", preferredStyle: UIAlertController.Style.alert)
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
                return false
            }
            if (passTextField.text!.count > 12) {
                let alert = UIAlertController(title: "Error", message: "Too many characters, only 12 character allowed in a password!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                emailTextField.text = ""
                passTextField.text = ""
                return false
            }
        }
        return true
    }
}

