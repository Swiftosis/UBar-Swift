//
//  PubDetailViewController.swift
//  UBar-Swift
//
//  Created by Bettina Hegedus on 2015. 10. 26..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

import UIKit


class PubDetailViewController: UIViewController {
    
    var pubName:String! = ""

    @IBOutlet weak var pubNameLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.pubNameLabel.text = self.pubName
    }
    
 
    
    
    
    
    
}

