//
//  AreaViewController.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 12/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit
import MBProgressHUD
import GoogleMaps

class AreaViewController: BaseViewController {
    
    fileprivate lazy var placesModel = Places()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 35.7574465, longitude: 139.6833125, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.hidesBackButton = true
        self.title = NSLocalizedString("Store", comment: "Saitama")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logoutUser))
        self.fetchPlaces()
    }
    
    @objc private func logoutUser() {
        AppFactory.shared.signOutUser()
        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc private func fetchPlaces() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        weak var weakSelf = self
        self.placesModel.getPlaces { (places, error, errorMessage) in
            DispatchQueue.main.async(execute: {
                if weakSelf != nil {
                    MBProgressHUD.hide(for: (weakSelf?.view)!, animated: true)
                }
                if places != nil {
                    //success
                    if weakSelf != nil {
                        let mapView = self.view as! GMSMapView
                        mapView.clear()
                        for place in places! {
                            let marker = PlaceMarker(withPlace: place)
                            marker.map = mapView
                        }
                    }
                }
                else {
                    if errorMessage != nil {
                        self.displayError(withMessage: errorMessage!, retrySelector: nil)
                    }
                    else {
                        self.displayError(withMessage: NSLocalizedString("Network Error.", comment: "Saitama"), retrySelector: #selector(self.fetchPlaces))
                    }
                }
            })
            
            
        }
    }
    
}
