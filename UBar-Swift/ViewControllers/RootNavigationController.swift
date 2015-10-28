//
//  RootNavigationController.swift
//  UBar-Swift
//
//  Created by Rab Gábor on 2015. 10. 27..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

import UIKit

// MARK: - View Controller Factory
func storyboardViewController(storyboardName storyboardName:String,storyboardID: String) -> UIViewController? {
    
    guard let viewController:UIViewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewControllerWithIdentifier(storyboardID) else {
        return nil
    }
    
    return viewController
}
// MARK: -
class RootNavigationController: UINavigationController {
    
    let networingManager = NetworkingManager.sharedInstance
    
    static var sharedRootVC:RootNavigationController? {
        get {

            guard let rootViewController:RootNavigationController = UIApplication.sharedApplication().delegate?.window??.rootViewController as? RootNavigationController else {
                return nil
            }
            
            return rootViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayLoadingScreen()


        
        self.networingManager.checkLogin(
            onLoggedIn: { [unowned self] () -> Void in
                self.loggedIn()
            },
            onNotLoggedIn: { [unowned self] () -> Void in
                self.displayUberWebViewScreen(urlToLoad: kAuthEndPointStr, loadType: .Login)
            },
            failure: nil)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Public interface

    func loggedIn() {
        self.displayMapScreen()
    }
    
    func displayLoadingScreen() {
        guard let loadingVC:LoadingViewController = storyboardViewController(storyboardName: "LoadingScreen", storyboardID: "LoadingViewController") as? LoadingViewController else {
            assert(true)
            return
        }
        self.navigationBarHidden = true
        self.setViewControllers( [loadingVC] , animated: true)
    }
    
    func displayUberWebViewScreen(urlToLoad url:String, loadType:UberWebViewLoadType) {
        guard let uberWebVC = storyboardViewController(storyboardName: "UberWebViewScreen", storyboardID: "UberWebViewController") as? UberWebViewController else {
            assert(true)
            return
        }
        
        uberWebVC.loadType = loadType
        uberWebVC.URLStringToLoad = url
        
        self.navigationBarHidden = true
        
        self.setViewControllers( [uberWebVC] , animated: true)
    }
    
    func displayMapScreen() {
        self.displayMapScreenAninated(false)
    }
    
    func displayMapScreenAninated(aninated:Bool) {
        guard let loadingVC:MapViewController = storyboardViewController(storyboardName: "CSAMapViewController", storyboardID: "CSAMapViewController") as? MapViewController else {
            assert(true)
            return
        }
        self.navigationBarHidden = true
        
        self.setViewControllers( [loadingVC] , animated: aninated)
    }
}
