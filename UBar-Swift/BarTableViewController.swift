//
//  BarTableViewController.swift
//  prototipus
//
//  Created by Bettina Hegedus on 2015. 10. 27..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

import UIKit

struct Pub {
    var name = ""
    var city = ""
    var open = ""
    var imageName = ""
}
let bars = [
    Pub(name: "Zöld Macska", city: "1091 Budapest\nÜllői út 95",open:"Open today\n 12:00 pm - 4:00 am" ,imageName:"zold_macska"),
    Pub(name: "Flamingo", city: "Esztergom Széchenyi tér 11, 2500",open:"Open today\n 12:00 pm - 4:00 am" ,imageName:"flamingo"),
    Pub(name: "Szimpla Kert", city: "Budapest Kazinczy u. 14, 1075",open:"Open today\n 12:00 pm - 4:00 am", imageName:"szimpl"),
    Pub(name: "Gong Café", city: "Budapest Erzsébet krt. 15, 1073",open:"Open today\n 12:00 pm - 4:00 am", imageName: "gong"),
    Pub(name: "Rózsa Domb Presszó", city: "Budapest Margit körút 7, 1027",open:"Open today\n 12:00 pm - 4:00 am", imageName: "rozsa")
]

class BarTableViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImageView = UIImageView(image: UIImage(named: "logo-white_no_text") )
        titleImageView.frame = CGRect(x: 0, y: 0, width: 30, height:44)
        titleImageView.contentMode = UIViewContentMode.ScaleAspectFit
        titleImageView.tintColor = UIColor.whiteColor()
        navigationItem.titleView = titleImageView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Popover
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.OverCurrentContext
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navController = UINavigationController(rootViewController: controller.presentedViewController)
        
        return navController
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bars.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("BarCell") else {
            return UITableViewCell()
        }
        let bar = bars[indexPath.row]
        cell.imageView!.image = UIImage(named: bar.imageName)
        cell.imageView!.layer.masksToBounds = true
        cell.textLabel!.text = bars[indexPath.row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC:PubDetailViewController = storyBoard.instantiateViewControllerWithIdentifier("PubDetailViewController") as! PubDetailViewController
        detailVC.pub = bars[indexPath.row]
        self.navigationController!.pushViewController(detailVC, animated: true)        
    }
}
