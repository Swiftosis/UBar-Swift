//
//  LoadingViewController.swift
//  UBar-Swift
//
//  Created by Bettina Hegedus on 2015. 10. 20..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        self.activityIndicatorView.startAnimating()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

