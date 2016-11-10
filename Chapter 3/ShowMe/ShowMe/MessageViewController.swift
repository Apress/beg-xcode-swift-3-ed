//
//  MessageViewController.swift
//  ShowMe
//
//  Created by Matthew Knott on 25/11/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    var messageData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        messageLabel.text = messageData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
