//
//  MyPin.swift
//  MapPin
//
//  Created by Matthew Knott on 30/07/2016.
//  Copyright © 2016 Matthew Knott. All rights reserved.
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
