//
//  StatesViewController.swift
//  EUStates
//
//  Created by Matthew Knott on 27/10/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit

class StatesViewController: UITableViewController {
    
    let states = NSMutableArray(capacity: 15)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = UIColor.redColor()
        
        initStates()
    }
    
    func initStates()
    {
        states[0] = "Austria"
        states[1] = "Belgium"
        states[2] = "Bulgaria"
        states[3] = "Croatia"
        states[4] = "Cyprus"
        states[5] = "Czech Republic"
        states[6] = "Denmark"
        states[7] = "Estonia"
        states[8] = "Finland"
        states[9] = "France"
        states[10] = "Germany"
        states[11] = "Greece"
        states[12] = "Hungary"
        states[13] = "Ireland"
        states[14] = "Italy"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StateCell", forIndexPath: indexPath) as UITableViewCell
        
        let cellText = "\(indexPath.row):  \(states[indexPath.row])"
        
        cell.textLabel.text = cellText
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
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
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
