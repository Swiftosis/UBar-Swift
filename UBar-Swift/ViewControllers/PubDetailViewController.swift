//
//  PubDetailViewController.swift
//  prototipus
//
//  Created by Bettina Hegedus on 2015. 10. 27..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

import UIKit

class PubDetailViewController : UIViewController {
    
    @IBOutlet weak var pubNameLabel: UILabel!
    @IBOutlet weak var pubAddressLabel: UILabel!
    @IBOutlet weak var pubHoursLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var pub:Pub?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pub = pub else {
            assert(true)
            return
        }
        self.pubNameLabel.text = pub.name
        self.pubAddressLabel.text = pub.city
        self.pubHoursLabel.text = pub.open
        self.imageView.image = UIImage(named: pub.imageName)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.imageView.layoutIfNeeded()
        self.imageView.layer.cornerRadius = imageView.frame.width / 2
        self.imageView.clipsToBounds = true
    }
}
