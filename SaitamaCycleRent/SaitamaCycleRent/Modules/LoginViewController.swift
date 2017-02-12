//
//  LoginViewController.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginSignupCombinedCell: UITableViewCell {
    @IBOutlet weak var loginButtonWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var loginButton:UIButton!
    @IBOutlet weak var registerButtonWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var registerButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let font = UIFont.systemFont(ofSize: 18.0)
        let loginText = NSLocalizedString("Login", comment: "Login")
        let loginWidth = loginText.textRect(withFont: font).size.width + 20.0
        
        let registerText = NSLocalizedString("Register", comment: "Login")
        let registerWidth = registerText.textRect(withFont: font).size.width + 20.0
        
        self.loginButton.setTitle(loginText, for: .normal)
        self.loginButton.layer.cornerRadius = 5.0
        self.loginButtonWidthConstraint.constant = loginWidth
        
        self.registerButton.setTitle(registerText, for: .normal)
        self.registerButton.layer.cornerRadius = 5.0
        self.registerButtonWidthConstraint.constant = registerWidth
        self.layoutIfNeeded()
    }
}

class LoginInputCell: UITableViewCell {
    @IBOutlet weak var leftLabel:UILabel!
    @IBOutlet weak var rightTextField:UITextField!
}

class LoginViewController: BaseViewController {

    public var pageState = LoginPageState.welcome
    
    fileprivate var activeTextField:UITextField?
    
    @IBOutlet weak var contentTable:UITableView!
    
    fileprivate lazy var userModel = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if AppFactory.shared.getCurrentUserToken() != nil {
            self.performSegue(withIdentifier: Constants.Segue.LoginToAreaNoAnimation, sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.userModel.clearCredentials()
        self.pageState = .welcome
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    @objc fileprivate func handleActionForWelcomeRegisterButton(_ sender:Any?) {
        self.activeTextField?.resignFirstResponder()
        self.pageState = .register
        self.userModel.clearCredentials()
        self.contentTable.reloadData()
    }
    
    @objc fileprivate func handleActionForWelcomeLoginButton(_ sender:Any?) {
        self.activeTextField?.resignFirstResponder()
        self.pageState = .login
        self.userModel.clearCredentials()
        self.contentTable.reloadData()
    }
    
    @objc fileprivate func toolBarButtonDoneAction(_ sender:Any?) {
        self.activeTextField?.resignFirstResponder()
    }
    
    @objc fileprivate func authenticateUser() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        weak var weakSelf = self
        do {
            try self.userModel.authentication(withCompletionHandler: { (accessToken, error, errorMessage) in
                weakSelf?.hideLoaderOnMainThread()
                if accessToken != nil {
                    //success
                    if weakSelf != nil {
                        AppFactory.shared.setUserToken(accessToken!)
                        weakSelf?.performSegue(withIdentifier: Constants.Segue.LoginToArea, sender: nil)
                    }
                }
                else {
                    if errorMessage != nil {
                        self.displayError(withMessage: errorMessage!, retrySelector: nil)
                    }
                    else {
                        self.displayError(withMessage: NSLocalizedString("Network Error.", comment: "Saitama"), retrySelector: #selector(self.authenticateUser))
                    }
                }
            })
        } catch UserAuthenticationCallError.blankEmail {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide email.", comment: "Login"), retrySelector: nil)
        } catch UserAuthenticationCallError.largeEmail {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide email with max length 128 characters.", comment: "Login"), retrySelector: nil)
        } catch UserAuthenticationCallError.invalidEmail {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide valid email.", comment: "Login"), retrySelector: nil)
        } catch UserAuthenticationCallError.blankPassword {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide password.", comment: "Login"), retrySelector: nil)
        } catch UserAuthenticationCallError.largePassword {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide password with max length 32 characters.", comment: "Login"), retrySelector: nil)
        } catch {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Unknown Error Occured.", comment: "Login"), retrySelector: #selector(self.authenticateUser))
        }
    }
    
    @objc fileprivate func registerUser() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        weak var weakSelf = self
        do {
            try self.userModel.register(withCompletionHandler: { (accessToken, error, errorMessage) in
                weakSelf?.hideLoaderOnMainThread()
                if accessToken != nil {
                    //success
                    if weakSelf != nil {
                        AppFactory.shared.setUserToken(accessToken!)
                        DispatchQueue.main.async(execute: {
                            let alert = UIAlertController(title: nil, message: NSLocalizedString("User registration successful", comment: "Login"), preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Login"), style: .default, handler: { (action) in
                                weakSelf?.performSegue(withIdentifier: Constants.Segue.LoginToArea, sender: nil)
                            }))
                            weakSelf?.present(alert, animated: true, completion: nil)
                        })
                    }
                }
                else {
                    if errorMessage != nil {
                        self.displayError(withMessage: errorMessage!, retrySelector: nil)
                    }
                    else {
                        self.displayError(withMessage: NSLocalizedString("Network Error.", comment: "Saitama"), retrySelector: #selector(self.authenticateUser))
                    }
                }
            })
        } catch UserRegisterCallError.blankEmail {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide email.", comment: "Login"), retrySelector: nil)
        } catch UserRegisterCallError.largeEmail {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide email with max length 128 characters.", comment: "Login"), retrySelector: nil)
        } catch UserRegisterCallError.invalidEmail {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide valid email.", comment: "Login"), retrySelector: nil)
        } catch UserRegisterCallError.blankPassword {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide password.", comment: "Login"), retrySelector: nil)
        } catch UserRegisterCallError.largePassword {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Please provide password with max length 32 characters.", comment: "Login"), retrySelector: nil)
        } catch {
            self.hideLoaderOnMainThread()
            self.displayError(withMessage: NSLocalizedString("Unknown Error Occured.", comment: "Login"), retrySelector: #selector(self.registerUser))
        }
    }
    
    fileprivate func showLoaderOnMainThread() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    fileprivate func hideLoaderOnMainThread() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

extension LoginViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.pageState {
        case .welcome:
            return 2
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pageState == .welcome {
            return 1
        }
        else {
            if section == 0 {
                return 1
            }
            else {
                return 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return getHeaderCell(forTable: tableView, andIndexPath: indexPath)
        }
        else {
            if self.pageState == .welcome {
                return getLoginSignupCombinedCell(forTable: tableView, andIndexPath: indexPath)
            }
            else {
                if indexPath.section == 1 {
                    return getInputCell(forTable: tableView, andIndexPath: indexPath)
                }
                else {
                    var cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.GeneralTableCell)
                    if cell == nil {
                        cell = UITableViewCell(style: .default, reuseIdentifier:Constants.CellIdentifier.GeneralTableCell)
                        cell?.textLabel?.textAlignment = .center
                    }
                    if indexPath.row == 0 {
                        if self.pageState == .login {
                            cell?.textLabel?.text = NSLocalizedString("Login", comment: "Login")
                        }
                        else {
                            cell?.textLabel?.text = NSLocalizedString("Register", comment: "Login")
                        }
                        cell?.textLabel?.textColor = .blue
                        cell?.textLabel?.font = UIFont.systemFont(ofSize: 18.0)
                    }
                    else {
                        if self.pageState == .login {
                            cell?.textLabel?.text = NSLocalizedString("Goto Register", comment: "Login")
                        }
                        else {
                            cell?.textLabel?.text = NSLocalizedString("Goto Login", comment: "Login")
                        }
                        cell?.textLabel?.textColor = .gray
                        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
                    }
                    cell?.selectionStyle = .none
                    return cell!
                }
            }
        }
    }
    
    private func getInputCell(forTable tableView:UITableView, andIndexPath indexPath:IndexPath) -> LoginInputCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.LoginInputCell) as! LoginInputCell
        cell.rightTextField.text = ""
        if indexPath.row == 0 {
            cell.rightTextField.keyboardType = .emailAddress
            cell.rightTextField.isSecureTextEntry = false
            cell.rightTextField.placeholder = NSLocalizedString("Email", comment: "Login")
            cell.leftLabel.text = NSLocalizedString("Email", comment: "Login")
            if self.userModel.email != nil {
                cell.rightTextField.text = self.userModel.email
            }
        }
        else {
            cell.rightTextField.keyboardType = .default
            cell.rightTextField.isSecureTextEntry = true
            cell.leftLabel.text = NSLocalizedString("Password", comment: "Login")
            cell.rightTextField.placeholder = NSLocalizedString("Password", comment: "Login")
            if self.userModel.password != nil {
                cell.rightTextField.text = self.userModel.password
            }
        }
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.size.width, height: 44.0))
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Login"), style: .done, target: self, action: #selector(self.toolBarButtonDoneAction(_:)))
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
    
    private func getLoginSignupCombinedCell(forTable tableView:UITableView, andIndexPath indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.LoginSignupCombinedCell) as! LoginSignupCombinedCell
        let allActions = cell.loginButton.actions(forTarget: self, forControlEvent: .touchUpInside)
        if ((allActions == nil) || (allActions?.count == 0)) {
            cell.loginButton.addTarget(self, action: #selector(self.handleActionForWelcomeLoginButton(_:)), for: .touchUpInside)
            cell.registerButton.addTarget(self, action: #selector(self.handleActionForWelcomeRegisterButton(_:)), for: .touchUpInside)
        }
        return cell
    }
    
    private func getHeaderCell(forTable tableView:UITableView, andIndexPath indexPath:IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.GeneralHeaderCell)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier:Constants.CellIdentifier.GeneralHeaderCell)
            cell?.textLabel?.textAlignment = .center
        }
        cell?.textLabel?.text = NSLocalizedString("Welcome to Saitama Cycles", comment: "Login")
        cell?.selectionStyle = .none
        return cell!
    }
}

extension LoginViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50.0
        }
        else {
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.activeTextField?.resignFirstResponder()
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                if self.pageState == .login {
                    //login request
                    self.authenticateUser()
                }
                else {
                    //register request
                    self.registerUser()
                }
            }
            else {
                if self.pageState == .login {
                    //goto register
                    self.handleActionForWelcomeRegisterButton(nil)
                }
                else {
                    //goto login
                    self.handleActionForWelcomeLoginButton(nil)
                }
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 0 {
            self.userModel.email = textField.text
        }
        else {
            self.userModel.password = textField.text
        }
    }
}
