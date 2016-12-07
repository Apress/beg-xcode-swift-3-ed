//
//  MessageViewController.swift
//  ShowMe
//
//  Created by Matthew Knott on 16/07/2016.
//  Copyright © 2016 Matthew Knott. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    var messageData: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = messageData
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
