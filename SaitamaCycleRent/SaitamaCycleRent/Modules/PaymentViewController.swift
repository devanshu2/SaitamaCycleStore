//
//  PaymentViewController.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 13/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit
import MBProgressHUD

class PaymentViewController: BaseViewController {
    
    @IBOutlet weak var contentTable:UITableView!
    @IBOutlet weak var payNowButton:UIButton!
    fileprivate var activeTextField:UITextField?
    fileprivate lazy var paymentModel = Payment()
    fileprivate var picker:CCDatePickerView!
    public var rentID:String?
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentTable.register(UINib(nibName: "TextInputTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIdentifier.InputCell)
        self.payNowButton.layer.cornerRadius = 5.0
        self.payNowButton.setTitle(NSLocalizedString("Pay Now", comment: "Payment"), for: .normal)
        self.picker = CCDatePickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.hidesBackButton = true
        self.title = NSLocalizedString("Payment", comment: "Saitama")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.popController))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.paymentModel.cancelActiveAPICallTask()
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    @objc private func popController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func toolBarButtonDoneAction(_ sender:UIBarButtonItem) {
        if sender.tag == 2 {
            let selectedMonth = self.picker.selectedMonth
            let selectedYear = self.picker.selectedYear
            let last2 = selectedYear.substring(from:selectedYear.index(selectedYear.endIndex, offsetBy: -2))
            self.paymentModel.expirationMonth = selectedMonth
            self.paymentModel.expirationYear = selectedYear
            self.contentTable.reloadData()
        }
        self.activeTextField?.resignFirstResponder()
    }
    
    private func callSuccessMessage() {
        DispatchQueue.main.async {
            weak var weakSelf = self
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Rented!!", comment: "Payment"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Payment"), style: .default, handler: { (action) in
                weakSelf?.popController()
            }))
            weakSelf?.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Api call
    @IBAction func payNow(_ sender:Any?) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        weak var weakSelf = self
        do {
            try self.paymentModel.rent(withCompletionHandler: { (success, error, errorMessage) in
                weakSelf?.hideLoaderOnMainThread()
                if success {
                    //success
                    if weakSelf != nil {
                        weakSelf?.callSuccessMessage()
                    }
                }
                else {
                    if errorMessage != nil {
                        self.displayError(withMessage: errorMessage!, retrySelector: nil)
                    }
                    else {
                        if ((error?._code != NSURLErrorUnknown) && (error?._code != NSURLErrorCancelled)) {
                            self.displayError(withMessage: NSLocalizedString("Network Error.", comment: "Saitama"), retrySelector: #selector(self.payNow(_:)))
                        }
                    }
                }
            })
        } catch RentPaymentCallError.invalidNumber {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide valid credit card number.", comment: "Payment"), retrySelector: nil)
        } catch RentPaymentCallError.blankName {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide your name as on credit card.", comment: "Payment"), retrySelector: nil)
        } catch RentPaymentCallError.invalidExpiry {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide valid expiry date.", comment: "Payment"), retrySelector: nil)
        } catch RentPaymentCallError.invalidCode {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide valid cvv code.", comment: "Payment"), retrySelector: nil)
        } catch {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Unknown Error Occured.", comment: "Login"), retrySelector: #selector(self.payNow(_:)))
        }
    }
}

// MARK: - Table data source
extension PaymentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.InputCell) as! TextInputTableViewCell
        cell.rightTextField.text = ""
        cell.rightTextField.inputView = nil
        if indexPath.row == 0 {
            cell.rightTextField.keyboardType = .numberPad
            cell.rightTextField.placeholder = NSLocalizedString("Card Number", comment: "Payment")
            cell.leftLabel.text = NSLocalizedString("Card Number", comment: "Payment")
            if self.paymentModel.number != nil {
                cell.rightTextField.text = self.paymentModel.number
            }
        }
        else if indexPath.row == 1 {
            cell.rightTextField.keyboardType = .default
            cell.rightTextField.placeholder = NSLocalizedString("Name", comment: "Payment")
            cell.leftLabel.text = NSLocalizedString("Name", comment: "Payment")
            if self.paymentModel.name != nil {
                cell.rightTextField.text = self.paymentModel.name
            }
        }
        else if indexPath.row == 2 {
            cell.rightTextField.placeholder = NSLocalizedString("Expiration", comment: "Payment")
            cell.leftLabel.text = NSLocalizedString("Expiration", comment: "Payment")
            if self.paymentModel.expiration != nil {
                cell.rightTextField.text = self.paymentModel.expiration
            }
            cell.rightTextField.inputView = self.picker
        }
        else {
            cell.rightTextField.keyboardType = .numberPad
            cell.rightTextField.placeholder = NSLocalizedString("CVV Code", comment: "Payment")
            cell.leftLabel.text = NSLocalizedString("CVV Code", comment: "Payment")
            if self.paymentModel.code != nil {
                cell.rightTextField.text = self.paymentModel.code
            }
        }
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.size.width, height: 44.0))
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Payment"), style: .done, target: self, action: #selector(self.toolBarButtonDoneAction(_:)))
        doneButton.tag = indexPath.row
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexibleSpace, doneButton]
        cell.rightTextField.tag = indexPath.row
        cell.rightTextField.inputAccessoryView = toolBar
        cell.rightTextField.delegate = self
        cell.rightTextField.tag = indexPath.row
        let allActions = cell.rightTextField.actions(forTarget: self, forControlEvent: .editingChanged)
        if ((allActions == nil) || (allActions?.count == 0)) {
            cell.rightTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        return cell
    }
}

// MARK: - Table delegate
extension PaymentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("Provide your payment details", comment: "Payment")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.activeTextField?.resignFirstResponder()
    }
}

// MARK: - Text field delegate
extension PaymentViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        
        if textField.tag == 0 {
            return newLength <= Constants.Restrictions.ccNumber
        }
        else if textField.tag == 3 {
            return newLength <= Constants.Restrictions.ccCode
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 0 {
            self.paymentModel.number = textField.text
        }
        else if textField.tag == 1 {
            self.paymentModel.name = textField.text
        }
        else if textField.tag == 3 {
            self.paymentModel.code = textField.text
        }
    }
}
