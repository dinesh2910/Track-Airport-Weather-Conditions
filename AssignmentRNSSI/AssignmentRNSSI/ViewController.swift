//
//  ViewController.swift
//  AssignmentRNSSI
//
//  Created by dinesh danda on 3/28/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var isTakenData : Bool = false
    var airport : Stations!
    
    var locArr = [Stations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.delegate = self;
        
        
        
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let loc = locations.last
        if !isTakenData {
            isTakenData = true
            let viewRegion = MKCoordinateRegionMakeWithDistance((loc?.coordinate)!, 2000, 2000)
            mapView.setRegion(viewRegion, animated: false)
            let params = "lat/\((loc?.coordinate.latitude)!)/lon/\((loc?.coordinate.longitude)!)/radius/25?type=A"
            
            SingletonClass.getService(endPoint: "station/", params: params, completionHandler: { (response, error) in
                
                if (error != nil) {
                    print(error!)
                }
                else{
                    //    print(response!)
                    
                    // let totalElements = response!["results"]!
                    
                    let stations = response!["data"]! as! [[String:Any]]
                    
                    
                    for station in stations{
                        self.locArr.append(Stations(station: station))
                        
                    }
                    
                    print(self.locArr)
                    //  print(stations)
                    var count = 0
                    for airport in self.locArr {
                        let annotation = Annotation()
                        annotation.title = airport.title
                        annotation.coordinate = CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)
                        annotation.index = count
                        count += 1
                        self.mapView.addAnnotation(annotation)
                    }
                    
                    // print(totalElements)
                }
            })
        }
    }
}

extension ViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)
    {
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation is Annotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinTintColor = .blue
            pinAnnotationView.isDraggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            pinAnnotationView.tag = (annotation as! Annotation).index
            //let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            let btn = UIButton(type: UIButtonType.detailDisclosure)
            btn.tag = (annotation as! Annotation).index
            btn.addTarget(self, action:#selector(handleRegister(sender : )), for: .touchUpInside)
            
            
            
            // pinAnnotationView.addGestureRecognizer(tap)
            
            pinAnnotationView.isUserInteractionEnabled = true
            pinAnnotationView.rightCalloutAccessoryView = btn
            
            
            return pinAnnotationView
        }
        return nil
        
        
        //        if annotation is MKUserLocation
        //        {
        //            return nil
        //        }
        //        else {
        //            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
        //            annotationView.image = UIImage(named: "gpsmap")
        //
        //            return annotationView
        //        }
    }
    @objc func handleRegister(sender : UIButton)  {
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewControler") as! DetailsViewControler
        dvc.airport = self.locArr[sender.tag]
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
    
    
    
    
}

