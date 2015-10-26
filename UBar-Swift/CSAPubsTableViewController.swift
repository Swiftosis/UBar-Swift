//
//  CSAPubsTableViewController.swift
//  UBar-Swift
//
//  Created by Bettina Hegedus on 2015. 10. 21..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

import UIKit


class CSAPubsTableViewController: UITableViewController {
    
   
    
    let pubs=[ CSAPubs(name: "Szimpla", city: "BP", street: "nemtom", number: 1, imageName: "szimpl"),
        CSAPubs(name: "Bagoly", city: "Karakóalsószörcsöge", street: "kaka", number: 12, imageName: "bagoly")]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
        let a = pubs[indexPath.row] as CSAPubs
        cell.textLabel?.text = a.name
        cell.imageView?.image = UIImage(named: a.imageName!)
        
    
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "DetailSegue"
        {
            let detailVC = ((segue.destinationViewController) as! PubDetailViewController)
            var path = self.tableView!.indexPathForSelectedRow!
            let strName = pubs[path.row].name
            detailVC.pubName = strName
            detailVC.title = "Pubs"
            
            
        }
        
        

       
        
  
        
        }
        
        



}
