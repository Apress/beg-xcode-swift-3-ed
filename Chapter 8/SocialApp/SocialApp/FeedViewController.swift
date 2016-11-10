//
//  FeedViewController.swift
//  SocialApp
//
//  Created by Matthew Knott on 30/09/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit
import Accounts
import Social



class FeedViewController: UITableViewController {

    var selectedAccount : ACAccount!
    var tweets : NSMutableArray?
    var imageCache : NSCache?
    var queue : NSOperationQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let accountData = userDefaults.objectForKey("selectedAccount") as NSData
        selectedAccount = NSKeyedUnarchiver.unarchiveObjectWithData(accountData) as ACAccount
        
        self.tabBarController?.navigationItem.title = selectedAccount.accountDescription
        self.tabBarController?.edgesForExtendedLayout = UIRectEdge.None
        
        queue = NSOperationQueue()
        queue!.maxConcurrentOperationCount = 4
        
        retrieveTweets()
    }
    
    func retrieveTweets() {
        tweets?.removeAllObjects()
        
        if let account = selectedAccount {
            //TODO : Updated Line
            let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
            let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
            
            request.account = account

            request.performRequestWithHandler()
            {
                responseData, urlResponse, error in
                
                if(urlResponse.statusCode == 200)
                {
                    var jsonParseError : NSError?
                    self.tweets = NSJSONSerialization.JSONObjectWithData(responseData,
                        options: NSJSONReadingOptions.MutableContainers,
                        error: &jsonParseError) as? NSMutableArray
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        if let tweetCount = self.tweets?.count {
            return tweetCount
        }
        else
        {
            return 0
        }
    }

    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell",
            forIndexPath: indexPath) as TweetCell

        let tweetData = tweets?.objectAtIndex(indexPath.row) as NSDictionary
        let userData = tweetData.objectForKey("user") as NSDictionary

        cell.tweetContent.text? = tweetData.objectForKey("text") as String
        cell.tweetUserName.text? = userData.objectForKey("name") as String
           
        let imageURLString = userData.objectForKey("profile_image_url") as String
        let image = imageCache?.objectForKey(imageURLString) as UIImage?
            
        if let cachedImage = image {
            cell.tweetUserAvatar.image = cachedImage
        }
        else
        {
            cell.tweetUserAvatar.image = UIImage(named: "camera.png")!
            
            queue?.addOperationWithBlock() {
                let imageURL = NSURL(string: imageURLString) as NSURL!
                let imageData = NSData(contentsOfURL: imageURL) as NSData?
                let image = UIImage(data: imageData!) as UIImage?
                
                if let downloadedImage = image {
                    NSOperationQueue.mainQueue().addOperationWithBlock(){
                        let cell = tableView.cellForRowAtIndexPath(indexPath) as TweetCell
                        
                            cell.tweetUserAvatar.image = downloadedImage
                        
                    }
                    
                    self.imageCache?.setObject(downloadedImage, forKey: imageURLString)
                }
            }
            
        }

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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "ComposeTweet")
        {
            let targetController = segue.destinationViewController as ComposeViewController
            
            targetController.selectedAccount = selectedAccount
        }
        else if(segue.identifier == "ShowTweet")
        {
            var path : NSIndexPath = self.tableView.indexPathForSelectedRow()!
            
            let tweetData = self.tweets!.objectAtIndex(path.row) as NSDictionary
            
            let targetController = segue.destinationViewController as TweetViewController
            
            targetController.selectedTweet = tweetData
        }
    }
    
}
