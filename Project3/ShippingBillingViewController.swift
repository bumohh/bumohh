//
//  ShippingBillingViewController.swift
//  Project3
//
//  Created by Tommy Phan on 6/3/21.
//

import UIKit

class ShippingBillingViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var apartment: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var phone: UITextField!
    static var fullName: String = ""
    static var shipAddress: String = ""
    static var shipCity: String = ""
    static var shipPostal: String = ""
    static var shipPhone: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstName.layer.borderColor = UIColor.clear.cgColor
        lastName.layer.borderColor = UIColor.clear.cgColor
        address.layer.borderColor = UIColor.clear.cgColor
        city.layer.borderColor = UIColor.clear.cgColor
        country.layer.borderColor = UIColor.clear.cgColor
        postalCode.layer.borderColor = UIColor.clear.cgColor
        phone.layer.borderColor = UIColor.clear.cgColor
    }

    @IBAction func firstName(_ sender: Any) {
        if firstName.text == "" {
            firstName.layer.borderColor = UIColor.red.cgColor
        } else {
            firstName.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBAction func lastName(_ sender: Any) {
        if lastName.text == "" {
            lastName.layer.borderColor = UIColor.red.cgColor
        } else {
            lastName.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBAction func address(_ sender: Any) {
        if address.text == "" {
            address.layer.borderColor = UIColor.red.cgColor
        } else {
            address.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBAction func city(_ sender: Any) {
        if city.text == "" {
            city.layer.borderColor = UIColor.red.cgColor
        } else {
            city.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBAction func country(_ sender: Any) {
        if country.text == "" {
            country.layer.borderColor = UIColor.red.cgColor
        } else {
            country.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBAction func postalCode(_ sender: Any) {
        if postalCode.text == "" {
            postalCode.layer.borderColor = UIColor.red.cgColor
        } else {
            postalCode.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBAction func phone(_ sender: Any) {
        if phone.text == "" {
            phone.layer.borderColor = UIColor.red.cgColor
        } else {
            phone.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func setStaticVariables() {
        ShippingBillingViewController.fullName = firstName.text! + " " + lastName.text!
        ShippingBillingViewController.shipAddress = address.text!
        ShippingBillingViewController.shipCity = city.text!
        ShippingBillingViewController.shipPostal = postalCode.text!
        ShippingBillingViewController.shipPhone = phone.text!
    }
    
    @IBAction func continueToPayment(_ sender: Any) {
        
        if (firstName.text == "" || lastName.text == "" || address.text == "" || city.text == "" || country.text == "" || postalCode.text == "" || phone.text == "") {
            print("please finish filling out everything")
        } else {
            print("everything is set")
            setStaticVariables()
            print("After setting, name: \(ShippingBillingViewController.fullName), address: \(ShippingBillingViewController.shipAddress), city: \(ShippingBillingViewController.shipCity), postal: \(ShippingBillingViewController.shipPostal), phone: \(ShippingBillingViewController.shipPhone)")
            let payVC = PaymentViewController(nibName: "PaymentViewController", bundle: nil)
            self.navigationController?.pushViewController(payVC, animated: true)
            payVC.modalTransitionStyle = .crossDissolve
            payVC.modalPresentationStyle = .fullScreen
            self.present(payVC, animated: true, completion: nil)
        }
        
    }
}
