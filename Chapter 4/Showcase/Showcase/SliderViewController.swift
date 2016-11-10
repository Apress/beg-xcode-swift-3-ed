//
//  SliderViewController.swift
//  Showcase
//
//  Created by Matthew Knott on 01/08/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController, UITextFieldDelegate {
    
    var redColor:CGFloat = 1.0
    var greenColor:CGFloat = 1.0
    var blueColor:CGFloat = 1.0
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redValue: UITextField!
    @IBOutlet weak var greenValue: UITextField!
    @IBOutlet weak var blueValue: UITextField!
    @IBAction func changeRed(sender: AnyObject) {
        redColor = CGFloat(redSlider.value)
        redValue.text = String(format: "%.0f",Float(redColor*255.0))
        updateColor()
    }
    @IBAction func changeGreen(sender: AnyObject) {
        greenColor = CGFloat(greenSlider.value)
        greenValue.text = String(format: "%.0f",Float(greenColor*255.0))
        updateColor()
    }
    @IBAction func changeBlue(sender: AnyObject) {
        blueColor = CGFloat(blueSlider.value)
        blueValue.text = String(format: "%.0f",Float(blueColor*255.0))
        updateColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValue.delegate = self
        greenValue.delegate = self
        blueValue.delegate = self
        
        updateColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateColor() {
        self.view.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}


