//
//  PubsTableViewController.swift
//  UBar-Swift
//
//  Created by Bettina Hegedus on 2015. 10. 21..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

import UIKit


class PubsTableViewController: UITableViewController {
    
    let pubs = [ Pub(name: "Szimpla", city: "BP", street: "nemtom", number: 1, imageName: "szimpl"),
        Pub(name: "Bagoly", city: "Karakóalsószörcsöge", street: "kaka", number: 12, imageName: "bagoly")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
//        self.tableView.rowHeight = 500
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pubs.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        
        let reuseID:String = "Szimpla"
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(reuseID) else {
            
            return UITableViewCell()
        }
       // cell.textLabel?.text = name[indexPath.item]
        let a = pubs[indexPath.row] as Pub
        cell.textLabel?.text = a.name
        cell.imageView?.image = UIImage(named: a.imageName!)
        
        
    
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC:PubDetailViewController = storyBoard.instantiateViewControllerWithIdentifier("PubDetailViewController") as! PubDetailViewController
        
        detailVC.pubName = pubs[indexPath.row].name
        
        self.navigationController!.pushViewController(detailVC, animated: true)
        
        
    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 20
//    }

    
        



}
