//
//  FollowingViewController.swift
//  SocialApp
//
//  Created by Matthew Knott on 20/10/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit
import Accounts
import Social

let reuseIdentifier = "Cell"

class FollowingViewController: UICollectionViewController {
    
    var following : NSMutableArray?
    var imageCache : NSCache?
    var queue : NSOperationQueue?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        queue = NSOperationQueue()
        queue?.maxConcurrentOperationCount = 4
        
        self.tabBarController?.navigationItem.title = "Following"
        
        retrieveUsers()
    }

    func retrieveUsers() {
        following?.removeAllObjects()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let accountData = userDefaults.objectForKey("selectedAccount") as NSData
        let selectedAccount = NSKeyedUnarchiver.unarchiveObjectWithData(accountData) as ACAccount

        let requestURL = NSURL(string: "https://api.twitter.com/1.1/friends/list.json?count=200")

        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                requestMethod: SLRequestMethod.GET,
                URL: requestURL,
                parameters: nil)

        request.account = selectedAccount

        request.performRequestWithHandler()
        {
            responseData, urlResponse, error in
            
            if(urlResponse.statusCode == 200)
            {
                var jsonParseError : NSError?
                let followingData = NSJSONSerialization.JSONObjectWithData(responseData,
                    options: NSJSONReadingOptions.MutableContainers,
                    error: &jsonParseError) as NSDictionary
                
                self.following = followingData.objectForKey("users") as? NSMutableArray
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.collectionView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let followCount = following?.count {
            return followCount
        }
        else
        {
            return 0
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell

        let userData = following?.objectAtIndex(indexPath.row) as NSDictionary
        let imageURLString = userData.objectForKey("profile_image_url") as String

        if let image = imageCache?.objectForKey(imageURLString) as? UIImage {
            let imageView = UIImageView(image: image) as UIImageView
            imageView.bounds = cell.frame
            cell.addSubview(imageView)
        }
        else
        {
            queue?.addOperationWithBlock() {
                let imageURL = NSURL(string: imageURLString) as NSURL?
                let imageData = NSData(contentsOfURL: imageURL!) as NSData?
                let image = UIImage(data: imageData!) as UIImage?
                
                if let downloadedImage = image {
                    NSOperationQueue.mainQueue().addOperationWithBlock(){
                        let imageView = UIImageView(image: image)
                        imageView.bounds = cell.frame
                        
                        if let cell = self.collectionView.cellForItemAtIndexPath(indexPath) as UICollectionViewCell! {
                            cell.addSubview(imageView)
                        }
                    }
                    
                    self.imageCache?.setObject(image!, forKey: imageURLString)
                }
            }
        }
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(collectionView: UICollectionView!, shouldHighlightItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(collectionView: UICollectionView!, shouldSelectItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(collectionView: UICollectionView!, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView!, canPerformAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView!, performAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) {
    
    }
    */

}
