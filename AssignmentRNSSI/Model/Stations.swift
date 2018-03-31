//
//  Stations.swift
//  AssignmentRNSSI
//
//  Created by dinesh danda on 3/29/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import Foundation
class Stations {
    var title: String = ""
    var code : String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    init(station : [String: Any]) {
        if let lat = station["latitude"] as? [String:Any]{
            //latitude = String(describing: lat["decimal"]!)
            
            latitude = lat["decimal"]! as! Double
        }
        if let lng = station["longitude"] as? [String:Any]{
            longitude = lng["decimal"]! as! Double
        }
        title = (station["name"]! as? String)!
        code = (station["icao"]! as? String)!
        
    }
    
}
