//
//  ViewController.swift
//  HelloWorld
//
//  Created by Matthew Knott on 10/07/2016.
//  Copyright © 2016 Matthew Knott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblOutput: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lblOutput.text = "Bonjour!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

