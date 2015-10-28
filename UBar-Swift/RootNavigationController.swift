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


        
//        self.networingManager.checkLogin(
//            onLoggedIn: { [unowned self] () -> Void in
//                self.loggedIn()
//            },
//            onNotLoggedIn: { [unowned self] () -> Void in
//                
//            },
//            failure: nil)
        
        
        // Test function!
        let secondsToWait = 3
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, ( Int64(UInt64(secondsToWait) * NSEC_PER_SEC) )), dispatch_get_main_queue(), {
            self.loggedIn()
        });
        //
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func loggedIn() {
        self.displayMapScreen()
    }
    
    // MARK: - Public interface
    
    func displayLoadingScreen() {
        guard let loadingVC:LoadingViewController = storyboardViewController(storyboardName: "LoadingScreen", storyboardID: "LoadingViewController") as? LoadingViewController else {
            assert(true)
            return
        }
        
        self.navigationBarHidden = true
        
        self.setViewControllers( [loadingVC] , animated: true)
        
        
    }
    
    func displayMapScreen() {
        guard let loadingVC:MapViewController = storyboardViewController(storyboardName: "CSAMapViewController", storyboardID: "CSAMapViewController") as? MapViewController else {
            assert(true)
            return
        }
        
        self.navigationBarHidden = true
        
        self.setViewControllers( [loadingVC] , animated: false)
    }

}
