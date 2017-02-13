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
    fileprivate var mapView: GMSMapView!
    fileprivate var clusterManager: GMUClusterManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the cluster manager with default icon generator and renderer.
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 35.7574465, longitude: 139.6833125, zoom: 10.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = self.mapView
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PaymentViewController
        destinationVC.rentID = sender as? String
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
                        self.mapView.clear()
                        for place in places! {
                            let item = PlaceMarker(withPlace: place)
                            self.clusterManager.add(item)
                            
                            // Call cluster() after items have been added to perform the clustering and rendering on map.
                            self.clusterManager.cluster()
                            
                            // Register self to listen to both GMUClusterManagerDelegate and GMSMapViewDelegate events.
                            self.clusterManager.setDelegate(self, mapDelegate: self)
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
    
    fileprivate func promptRent(withID id:String, andTitle title:String) {
        weak var weakSelf = self
        let alert = UIAlertController(title: title, message: NSLocalizedString("Do you want to rent?", comment: "Saitama"), preferredStyle: .alert)
        let yes = UIAlertAction(title: NSLocalizedString("Yes", comment: "Saitama"), style: .default) { (yesAction) in
            self.performSegue(withIdentifier: Constants.Segue.AreaToPay, sender: id)
        }
        let no = UIAlertAction(title: NSLocalizedString("No", comment: "Saitama"), style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true, completion: nil)
    }
}

extension AreaViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? PlaceMarker {
            self.promptRent(withID: poiItem.id!, andTitle: poiItem.name!)
            NSLog("Did tap marker for cluster item \(poiItem.name)")
            return true
        } else {
            NSLog("Did tap a normal marker")
        }
        return false
    }
}

extension AreaViewController: GMUClusterManagerDelegate {
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: self.mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        self.mapView.moveCamera(update)
        return false
    }
}
