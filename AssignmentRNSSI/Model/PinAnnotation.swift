//
//  PinAnnotation.swift
//  AssignmentRNSSI
//
//  Created by dinesh danda on 3/29/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import Foundation
import MapKit
import Foundation
import UIKit

class PinAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    var annTitle : String = ""
    var annSubtitle : String = ""
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
}
