//
//  ViewController.swift
//  ShowMe
//
//  Created by Matthew Knott on 16/07/2016.
//  Copyright © 2016 Matthew Knott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textToSendField: UITextField!
    @IBAction func showMe(_ sender: AnyObject) {
        NSLog("User Wrote: %@", textToSendField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let messageController = segue.destination as! MessageViewController
        messageController.messageData = textToSendField.text
    }

}

