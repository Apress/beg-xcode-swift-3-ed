//
//  TrackViewController.swift
//  Showcase
//
//  Created by Matthew Knott on 01/08/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit
import CoreLocation

class TrackViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var locationText: UITextView!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBAction func changeToggle(sender: AnyObject) {
        if(toggleSwitch.on)
        {
            if (CLLocationManager.locationServicesEnabled() == false) {
                self.toggleSwitch.on = false
            }
            
            if locationManager == nil {
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.distanceFilter = 10.0
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.startUpdatingLocation()
        }
            else
        {
            if locationManager != nil {
                locationManager.stopUpdatingLocation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[locations.endIndex-1] as CLLocation
        self.locationText.text = location.description;
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationText.text = "failed with error \(error.description) "
    }
}

