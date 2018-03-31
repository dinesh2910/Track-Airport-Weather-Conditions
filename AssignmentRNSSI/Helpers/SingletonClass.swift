//
//  SingletonClass.swift
//  AssignmentRNSSI
//
//  Created by dinesh danda on 3/29/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import Foundation
import UIKit

class SingletonClass {
    static let sharedManager = SingletonClass()
    static let rootPath = "https://api.checkwx.com/"
    static let apiKey = "7dd788705bae51c0be7ade55d1"
    
    class  func getService(endPoint : String , params : String ,completionHandler : @escaping(_ jsonResponse : [String:Any]? , _ error : Error?)-> Void)  {
        
        
        let url = SingletonClass.rootPath + endPoint + params
        
        print("BEGIN:Assignment======>ServiceName:" + url)
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        
        //   request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(SingletonClass.apiKey, forHTTPHeaderField: "X-API-Key")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, err in
            
            guard err == nil else {
                
                completionHandler(nil, err)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, err)
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]{
                    
                    completionHandler(json , nil)
                    
                    print(json)
                    // handle json...
                }
            } catch let error {
                
                completionHandler(nil , error)
                
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    //   class func getLatitudeLongitude(Loc : [String : Any]) -> Location {
    //
    //        //print(Loc)
    //        var station = Location()
    //
    //        if let lat = Loc["latitude"] as? [String:Any]{
    //            station.latitude = String(describing: lat["decimal"]!)
    //        }
    //        if let lng = Loc["longitude"] as? [String:Any]{
    //            station.longitude = String(describing: lng["decimal"]!)
    //        }
    //        station.title = (Loc["icao"]! as? String)!
    //
    //
    //        return station
    //        // station.latitude = Loc["latitude"]!["decimal"] as! String
    //    }
}

