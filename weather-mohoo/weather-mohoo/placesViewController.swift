//
//  ViewController.swift
//  weather
//
//  Created by mohoo on 14-8-12.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//

import UIKit
import CoreLocation

class GPSViewController: UIViewController,CLLocationManagerDelegate {
  
    var detail = DetailViewController()
    let locationManger:CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
        if(ios8()){
            locationManger.requestAlwaysAuthorization()
        }
        locationManger.startUpdatingLocation()
    }
    func ios8()->Bool{
        return UIDevice.currentDevice().systemVersion == "8.0"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //地理位置发生变化会回传，返回可空数组
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[locations.count-1] as CLLocation
        //看看是否复合我们的标准
        if(location.horizontalAccuracy>0){
            println(location.coordinate.latitude)
            println(location.coordinate.longitude)
           var countrycity = "\(location.coordinate.longitude)"+",\(location.coordinate.latitude)"
            println(countrycity)
            detail.countrycity = countrycity
            locationManger.stopUpdatingLocation()//回值之后借宿定位
        }
    }
    //
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println(error)
    }
}

