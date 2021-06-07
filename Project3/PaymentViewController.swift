//
//  PaymentViewController.swift
//  Project3
//
//  Created by Edward Guilllermo on 6/1/21.
//

import UIKit

class PaymentViewController: UIViewController {

    
    @IBOutlet var paymentOptions: [UIButton]!
    @IBOutlet weak var creditCardPaymentView: UIView!
    @IBOutlet weak var cashOnDeliveryPaymentView: UIView!
    @IBOutlet weak var netBankingPaymentView: UIView!
    
    @IBOutlet weak var nameOnCardTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var validThroughTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var bankChosenLabel: UILabel!
    @IBOutlet weak var netBankingAmountLabel: UILabel!
    @IBOutlet var viewButtons: [UIButton]!
    @IBOutlet var viewTextFields: [UITextField]!
    
    @IBOutlet weak var ccPayButton: UIButton!
    @IBOutlet weak var codAmountLabel: UILabel!
    var userCart = DatabaseHelper.inst.fetchUserCart(currUser: ViewController.currentUserLogged)
    var obj: shipInfoObj?
    var validCredentials: Bool?
    let uniqueID = UUID().uuidString

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewBorders()
        setupButtonBorders()
        setupTextFieldBorders()
        setupLabelAmounts()
    }
    
    func setupLabelAmounts() {
        var total = String(format: "%.2f", getTotalAmount())
        codAmountLabel.text = "$\(total)"
        ccPayButton.setTitle("Pay $\(total)", for: .normal)
        netBankingAmountLabel.text = "$\(total)"
    }
    
    func hideMenuButtonsOnClick() {
        paymentOptions.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func setupTextFieldBorders() {
        for vtf in viewTextFields {
            vtf.layer.cornerRadius = 10.0
            vtf.layer.masksToBounds = true
            vtf.layer.borderWidth = 1.0
            vtf.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func setupViewBorders() {
        //CC View
        creditCardPaymentView.layer.cornerRadius = 10.0
        creditCardPaymentView.layer.masksToBounds = true
        //netBank View
        netBankingPaymentView.layer.cornerRadius = 10.0
        netBankingPaymentView.layer.masksToBounds = true
        //CoD View
        cashOnDeliveryPaymentView.layer.cornerRadius = 10.0
        cashOnDeliveryPaymentView.layer.masksToBounds = true
    }
    
    func setupButtonBorders() {
        for b in paymentOptions {
            b.layer.cornerRadius = 10.0
            b.layer.masksToBounds = true
            b.layer.borderWidth = 1.0
            b.layer.borderColor = UIColor.black.cgColor
        }
        
        for vb in viewButtons {
            vb.layer.cornerRadius = 10.0
            vb.layer.masksToBounds = true
            vb.layer.borderWidth = 1.0
            vb.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func hideView(caseNumber: Int) {
        switch caseNumber {
        case 0:
            cashOnDeliveryPaymentView.isHidden = false
            netBankingPaymentView.isHidden = true
            creditCardPaymentView.isHidden = true
        case 1:
            cashOnDeliveryPaymentView.isHidden = true
            netBankingPaymentView.isHidden = false
            creditCardPaymentView.isHidden = true
        case 2:
            cashOnDeliveryPaymentView.isHidden = true
            netBankingPaymentView.isHidden = true
            creditCardPaymentView.isHidden = false
        default:
            print("No Valid Option")
        }
    }
    
    func transitionToMainMenu() {
        DatabaseHelper.inst.removeAllFromCart(currUser: ViewController.currentUserLogged)
        //remove cart
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(identifier: "Main") as ViewController
        mainViewController.modalTransitionStyle = .crossDissolve
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    @IBAction func selectPaymentOptionButton(_ sender: UIButton) {
        hideMenuButtonsOnClick()
    }
    
    @IBAction func cashOnDeliveryButton(_ sender: Any) {
        hideMenuButtonsOnClick()
        hideView(caseNumber: 0)
    }
    
    @IBAction func netBankingButton(_ sender: Any) {
        hideMenuButtonsOnClick()
        hideView(caseNumber: 1)
    }
    
    @IBAction func creditCardButton(_ sender: Any) {
        hideMenuButtonsOnClick()
        hideView(caseNumber: 2)
    }
    
    func getTotalAmount() -> Float {
        var total: Float = 0.0
        for u in userCart {
            total += u.price
        }
        return total
    }
    
    func setShippingObjectValues() -> shipInfoObj {
        if DatabaseHelper.inst.checkShipping(currUser: ViewController.currentUserLogged) {
            obj = DatabaseHelper.inst.fetchShippingInfo(currUser: ViewController.currentUserLogged)[0]
            return obj!
        } else {
        let name = ShippingBillingViewController.fullName
        let address = ShippingBillingViewController.shipAddress
        let city = ShippingBillingViewController.shipCity
        let postalCode = ShippingBillingViewController.shipPostal
        let phoneNumber = ShippingBillingViewController.shipPhone
        let total = getTotalAmount()
        let obj = shipInfoObj(name: name, phoneNumber: phoneNumber, address: address, city: city, postalCode: postalCode)
        print("inside setting shipping object values")
        print(obj)
        return obj
        }
    }
    
    @IBAction func cashOnDeliveryConfirmButton(_ sender: Any) {
        print("Payment Confirmed")
        /*
        var obj: shipInfoObj
        obj.name = ShippingBillingViewController.fullName
        obj.address = ShippingBillingViewController.shipAddress
        obj.city = ShippingBillingViewController.shipCity
        obj.postalCode = ShippingBillingViewController.shipPostal
        obj.phoneNumber = ShippingBillingViewController.shipPhone
        obj.total = getTotalAmount()
         */
        //DatabaseHelper.inst.addShipping(currUser: ViewController.currentUserLogged, obj: setShippingObjectValues())
        //add order to user
        DatabaseHelper.inst.addOrder(currUser: ViewController.currentUserLogged, shippingInfo: setShippingObjectValues(), cart: userCart, uID: uniqueID)
        transitionToMainMenu()
    }
    
    @IBAction func creditCardPayButton(_ sender: Any) {
        validCredentials = validateCreditCardPayment()
        if (validCredentials!) {
            print("Payment Confirmed")
            //DatabaseHelper.inst.addShipping(currUser: ViewController.currentUserLogged, obj: setShippingObjectValues())
            //add order to user
            DatabaseHelper.inst.addOrder(currUser: ViewController.currentUserLogged, shippingInfo: setShippingObjectValues(), cart: userCart, uID: uniqueID)
            transitionToMainMenu()
        }
    }
    
    @IBAction func netBankingConfirmButton(_ sender: Any) {
        print("Payment Confirmed")
        //DatabaseHelper.inst.addShipping(currUser: ViewController.currentUserLogged, obj: setShippingObjectValues())
        DatabaseHelper.inst.addOrder(currUser: ViewController.currentUserLogged, shippingInfo: setShippingObjectValues(), cart: userCart, uID: uniqueID)
        transitionToMainMenu()
    }
    
    enum Banks: String {
        case bofa = "BofA"
        case chase = "Chase"
        case wells = "Wells"
    }
    
    @IBAction func bankTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let bank = Banks(rawValue: title) else {
            return
        }
        switch bank {
        case .bofa:
            bankChosenLabel.text = "Bank Chosen: Bank of America"
        case .chase:
            bankChosenLabel.text = "Bank Chosen: Chase"
        case .wells:
            bankChosenLabel.text = "Bank Chosen: Wells Fargo"
        default:
            print("default")
        }
    }
    
    
    func validateCreditCardPayment() -> Bool {
        if (nameOnCardTextField.text == "" || cardNumberTextField.text == "" || validThroughTextField.text == "" || cvvTextField.text == "") {
            let alert = UIAlertController(title: "Error", message: "Please fill out all text fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if (nameOnCardTextField.text!.count > 30) {
            let alert = UIAlertController(title: "Error", message: "Invalid Card Name, Name Text Field must not exceed 30 characters!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            nameOnCardTextField.text = ""
            return false
        }
        if (cardNumberTextField.text!.count != 16) {
            let alert = UIAlertController(title: "Error", message: "Invalid Card Number, Please enter your 16 digit Card Number!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            cardNumberTextField.text = ""
            return false
        }
        if (validThroughTextField.text!.count != 5) {
            let alert = UIAlertController(title: "Error", message: "Invalid Date, Please input a valid date (Ex. 01/20)!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            validThroughTextField.text = ""
            return false
        }
        if (cvvTextField.text!.count != 3) {
            let alert = UIAlertController(title: "Error", message: "Invalid CVV, Please Enter the 3 digit number at the back of your card!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            cvvTextField.text = ""
            return false
        }
        return true
    }
    
}
