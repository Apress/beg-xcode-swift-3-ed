//
//  ViewController.swift
//  LoginApp
//
//  Created by Matthew Knott on 06/11/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameField.delegate = self
        passwordField.delegate = self
        
    }
    
func textFieldShouldReturn(textField: UITextField) -> Bool {
    let nextTag = textField.tag + 1 as Int
    var nextField : UIResponder? = textField.superview?.viewWithTag(nextTag)
    
    if let field : UIResponder = nextField {
        field.becomeFirstResponder()
    }
    else
    {
        textField.resignFirstResponder()
    }
    
    return false
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

