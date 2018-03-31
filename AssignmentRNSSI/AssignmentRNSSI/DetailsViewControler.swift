//
//  DetailsViewControler.swift
//  AssignmentRNSSI
//
//  Created by dinesh danda on 3/28/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit

class DetailsViewControler: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var airport : Stations!
    var details : StationDetails!
    @IBOutlet var lblAirportName: UILabel!
    
    @IBOutlet var tableDetails: UITableView!
    let tableArray = ["ICAO Code","Observed Date","Amount of the sky occupied by clouds","Cloud Base height","Barometer","Temperature","Dew Point","Visibility","Wind"];
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(airport.code)
        self.lblAirportName.text=airport.title;
        self.tableDetails.tableFooterView = UIView()
        let params = "\(airport.code)/decoded"
        SingletonClass.getService(endPoint: "metar/", params: params) { (response, err) in
            if err != nil{
                
            }
            else{
                print(response!)
                let dataArr = response!["data"]
                if dataArr is [[String:Any]]{
                    
                    let dataaaa = dataArr as! [[String:Any]]
                    self.details = StationDetails(json : dataaaa[0])
                    print(self.details)
                    DispatchQueue.main.async {
                        self.tableDetails.delegate=self;
                        self.tableDetails.dataSource=self;
                        self.tableDetails.reloadData()
                    }
                }
                else{
                    let err = response!["data"] as! [String]
                    print(err[0])
                    
                    let alertController = UIAlertController(title: "No Data", message: "\(err[0])", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableArray.count;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4{
            return 3
        }
        else if section == 8
        {
            return 2
        }
        return 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let aStr = String(format: "%@%x", "timeNow in hex: ", timeNow)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if !(cell != nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        if indexPath.section == 0 {
            cell?.textLabel?.text = details.icaoCode;
        }
        else if indexPath.section == 1{
            cell?.textLabel?.text = details.observedTime
            
        }
        else if indexPath.section == 2{
            cell?.textLabel?.text = details.amountOfTheSkyOccupiedByTheClouds
        }
        else if indexPath.section == 4{
            
            if indexPath.row == 1{
                //hg
                cell?.textLabel?.text = "hg :\(details.hg) inches of mercury"
            }
            else if indexPath.row == 2{
                //                kpa
                cell?.textLabel?.text = "kpa :\(details.kpa) kilopascals";
            }
            else {
                //                mb
                cell?.textLabel?.text = "mb :\(details.mb) millibars";
            }
            
        }
        else if indexPath.section == 3{
            cell?.textLabel?.text = "\(details.cloudBaseHeight) Feets"
        }
        else if indexPath.section == 5{
            cell?.textLabel?.text = "\(details.temperature) Fahrenheits";
            
        } else if indexPath.section == 6{
            cell?.textLabel?.text = "\(details.dewPoint) Fahrenheits";
            
        }
            
        else if indexPath.section == 7{
            cell?.textLabel?.text = "\(details.visibility) Meters";
        }
        else if indexPath.section == 8{
            if indexPath.row == 1{
                cell?.textLabel?.text = "\(details.degrees) Degrees";
                
            }
            else {
                cell?.textLabel?.text = "\(details.windSpeed_mph) MPH";
                
            }
        }
        
        //cell?.textLabel?.text = "Text";
        return cell!;
    }
    
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return tableArray[section]
    }
    
    
}

