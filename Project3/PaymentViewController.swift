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
    
    
    var validCredentials: Bool?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewBorders()
        setupButtonBorders()
        setupTextFieldBorders()
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
    
    @IBAction func cashOnDeliveryConfirmButton(_ sender: Any) {
        print("Payment Confirmed")
        //Put code to save details to My Orders
        transitionToMainMenu()
    }
    
    @IBAction func creditCardPayButton(_ sender: Any) {
        validCredentials = validateCreditCardPayment()
        if (validCredentials!) {
            print("Payment Confirmed")
            //Put code to save details to My Orders
            transitionToMainMenu()
        }
    }
    
    @IBAction func netBankingConfirmButton(_ sender: Any) {
        print("Payment Confirmed")
        //Put code to save details to My Orders
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