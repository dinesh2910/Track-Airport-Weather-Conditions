//
//  StationDetails.swift
//  AssignmentRNSSI
//
//  Created by dinesh danda on 3/29/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import Foundation
class StationDetails {
    
    var name: String = ""
    var icaoCode : String = ""
    var observedTime: String = ""
    var amountOfTheSkyOccupiedByTheClouds:String = ""
    var cloudBaseHeight : Double = 0.0
    var baroMeter : [String : Double] = ["" : 0.0]
    //    hg = "29.76";
    //    kpa = "100.78";
    //    mb = 1008;
    var hg : Double = 0.0
    var kpa : Double = 0.0
    var mb : Double = 0.0
    var temperature : Int = 0 // in celsius
    var dewPoint : Int = 0 // in celsius
    var visibility : String = ""
    var wind : [String : Int] = ["" : 0]
    var degrees : Int = 0
    
    var windSpeed_mph : Int = 0
    
    init(json : [String:Any]) {
        if let clouds = json["clouds"] as? [[String:Any]]{
            
            if clouds.count>0
            {
                let element = clouds[0]
                
                amountOfTheSkyOccupiedByTheClouds = element["text"] as! String
                cloudBaseHeight = element["base_feet_agl"] as! Double
            }
            else{
                amountOfTheSkyOccupiedByTheClouds = "No Data Found"
                cloudBaseHeight = 0.0
            }
            //latitude = String(describing: lat["decimal"]!)
        }
        
        if let baroMeter = json["barometer"] as? [String:Double]{
            hg = baroMeter["hg"]!
            mb = baroMeter["mb"]!
            kpa = baroMeter["kpa"]!
            
        }
        if let temperatureDict = json["temperature"] as? [String:Int]{
            temperature = temperatureDict["fahrenheit"]!
            
        }
        if let dewPointDict = json["dewpoint"] as? [String:Int]{
            dewPoint = dewPointDict["fahrenheit"]!
        }
        
        if let visibilityDict = json["visibility"] as? [String:String]{
            visibility = visibilityDict["meters"]!
        }
        
        if let windDict = json["wind"] as? [String:Int]{
            degrees = windDict["degrees"]!
            windSpeed_mph = windDict["speed_mph"]!
            
        }
        name = (json["name"]! as? String)!
        icaoCode = (json["icao"]! as? String)!
        observedTime = (json["observed"]! as? String)!
        
    }
}

