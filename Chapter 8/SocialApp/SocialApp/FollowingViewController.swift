//
//  FollowingViewController.swift
//  SocialApp
//
//  Created by Matthew Knott on 10/08/2016.
//  Copyright © 2016 Matthew Knott. All rights reserved.
//

import UIKit
import Accounts
import Social

private let reuseIdentifier = "FollowerCell"

class FollowingViewController: UICollectionViewController {
    
    var following : NSMutableArray?
    var imageCache : NSCache<AnyObject, AnyObject>?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.tabBarController?.navigationItem.title = "Following"
        
        retrieveUsers()

    }

    func retrieveUsers() {
        following?.removeAllObjects()
        
        let userDefaults = UserDefaults.standard
        let accountData = userDefaults.object(forKey: "selectedAccount") as! Data
        let selectedAccount = NSKeyedUnarchiver.unarchiveObject(with: accountData) as! ACAccount
        
        let requestURL = URL(string: "https://api.twitter.com/1.1/friends/list.json?count=200")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: SLRequestMethod.GET,
                                url: requestURL,
                                parameters: nil) {
        
            request.account = selectedAccount
            
            request.perform()
            {
                responseData, urlResponse, error in
                
                if(urlResponse?.statusCode == 200)
                {
                    do {
                        let followingData = try JSONSerialization.jsonObject(with: responseData!,
                                                                                       options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        
                        self.following = followingData.object(forKey: "users") as? NSMutableArray
                    }
                    catch let error as NSError {
                        print("json error: \(error.localizedDescription)")
                    }
                }
                
                DispatchQueue.main.async {
                    self.collectionView!.reloadData()
                }
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
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let followCount = following?.count {
            return followCount
        }
        else
        {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        let userData = following?.object(at: indexPath.row) as! NSDictionary
        let imageURLString = userData.object(forKey: "profile_image_url") as! String
    
        let operationQueue = OperationQueue.main
        operationQueue.maxConcurrentOperationCount = 4
        
        if let image = imageCache?.object(forKey: imageURLString as AnyObject) as? UIImage {
            let imageView = UIImageView(image: image) as UIImageView
            imageView.bounds = cell.frame
            cell.addSubview(imageView)
        }
        else
        {
            operationQueue.addOperation() {
                let imageURL = URL(string: imageURLString)
                
                do {
                    if let imageData : Data = try Data(contentsOf: imageURL!) {
                        
                        let image = UIImage(data: imageData) as UIImage?
                        
                        if let downloadedImage = image {
                            OperationQueue.main.addOperation(){
                                let imageView = UIImageView(image: downloadedImage)
                                imageView.bounds = cell.frame
                                
                                if let cell = self.collectionView!.cellForItem(at: indexPath) as UICollectionViewCell! {
                                    cell.addSubview(imageView)
                                }
                            }
                            
                            self.imageCache?.setObject(downloadedImage, forKey: imageURLString as AnyObject)
                        }
                    }
                }
                catch let error as NSError {
                    print("parse error: \(error.localizedDescription)")
                }
            }
            
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
