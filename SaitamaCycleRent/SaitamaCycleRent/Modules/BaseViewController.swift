//
//  BaseViewController.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit
import MBProgressHUD

public class BaseViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    public func displayError(withMessage message:String, retrySelector:Selector?) {
        DispatchQueue.main.async {
            weak var weakSelf = self
            let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Login"), message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Login"), style: .default, handler: nil))
            if retrySelector != nil {
                alert.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment: "Login"), style: .default, handler: { (action) in
                    if weakSelf != nil {
                        weakSelf!.perform(retrySelector!)
                    }
                }))
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    public func showLoaderOnMainThread() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    public func hideLoaderOnMainThread() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
