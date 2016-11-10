//
//  ActionViewController.swift
//  Showcase
//
//  Created by Matthew Knott on 01/08/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {

    @IBOutlet weak var actionControl: UISegmentedControl!
    @IBOutlet weak var showmeButton: UIButton!
    @IBAction func performAction(sender: AnyObject) {
        if actionControl.selectedSegmentIndex == 0 {
            var controller : UIAlertController = UIAlertController(title: "This is an alert",
                message: "You've created an alert view",
                preferredStyle: UIAlertControllerStyle.Alert);
            
            var okAction : UIAlertAction = UIAlertAction(title: "Okay",
                style: UIAlertActionStyle.Default,
                handler: {
                    (alert: UIAlertAction!) in controller.dismissViewControllerAnimated(true, completion: nil)
            })
            
            controller.addAction(okAction);
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
        else
        {
            var controller : UIAlertController = UIAlertController(title: "This is an action sheet",
                message: "You've created an action sheet",
                preferredStyle: UIAlertControllerStyle.ActionSheet);
            
            var okAction : UIAlertAction = UIAlertAction(title: "Okay",
                style: UIAlertActionStyle.Default,
                handler: {
                    (alert: UIAlertAction!) in controller.dismissViewControllerAnimated(true, completion: nil)
            })
            
            controller.addAction(okAction);
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showmeButton.backgroundColor =
            UIColor(red: 9/255.0, green: 95/255.0, blue: 134/255.0, alpha: 1.0)
        showmeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        showmeButton.layer.cornerRadius = 4.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
