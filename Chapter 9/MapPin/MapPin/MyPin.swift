//
//  MyPin.swift
//  MapPin
//
//  Created by Matthew Knott on 30/08/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit
import MapKit

class MyPin: MKPointAnnotation {
   
    init(title : String, subtitle : String, coordinate : CLLocationCoordinate2D) {
        super.init()
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
