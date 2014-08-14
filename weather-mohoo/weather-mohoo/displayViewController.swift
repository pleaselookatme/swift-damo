//
//  ViewController.swift
//  weather-mohoo
//
//  Created by hy on 14-8-11.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//

import UIKit
import CoreLocation

class displayViewController: UIViewController,CLLocationManagerDelegate {
    let locationManger:CLLocationManager = CLLocationManager()
    var results = NSArray()
    var countrycity = ""
    var currentdate = String()
    var currentCity = String()
    var pm25data = NSString()
    var topimage = UIImageView(frame:CGRect(x: 0, y: 0, width: 320, height: 480))
    var degree :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManger.delegate = self
        locationManger.desiredAccuracy=kCLLocationAccuracyHundredMeters
        //locationManger.desiredAccuracy = kCLLocationAccuracyBest//精度
        
        if(ios8()){
            locationManger.requestAlwaysAuthorization()
        }
        locationManger.startUpdatingLocation()
        
        
  
    }
    
    
    func loaddata(countrycity:NSString){
        var url = "http://api.map.baidu.com/telematics/v3/weather?location=" + "\(countrycity)" + "%E5%8D%97%E4%BA%AC&output=json&ak=DCb2d6df5f7f732e4daeeadde7b2470c"
        HttpRequest.requestWithURL(url, completionHandler: { data in
            
            if data as NSObject == NSNull(){
                println("1233455")
                var alert = UIAlertController(title: "提示", message: "获取信息失败！", preferredStyle: .Alert)
                var actionback = UIAlertAction(title: "返回", style: .Default, handler: nil)
                alert.addAction(actionback)
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }else{
                self.results = data["results"] as NSArray
                self.currentCity = self.results[0].objectForKey("currentCity") as NSString
                self.currentdate = data["date"] as NSString
                self.pm25data = self.results[0].objectForKey("pm25")as NSString
                var index = self.results[0].objectForKey("index") as NSArray
                var title =  index[self.degree].objectForKey("title") as NSString
                var zs = index[self.degree].objectForKey("zs") as NSString
                var des = index[self.degree].objectForKey("des") as NSString
                var tipt = index[self.degree].objectForKey("tipt") as NSString

                
                var zsLabel = UILabel()
                zsLabel.frame = CGRectMake(180.0, 50.0, 140.0, 50.0)
                zsLabel.text =  zs
                zsLabel.font = UIFont(name:nil, size:42.0)
                zsLabel.textColor = UIColor.blueColor()
                zsLabel.textAlignment = NSTextAlignment.Left
                self.view.addSubview(zsLabel)
                
                
                var tiptLabel = UILabel()
                tiptLabel.frame = CGRectMake(15.0, 50.0, 140.0, 20.0)
                tiptLabel.text = tipt
                tiptLabel.font = UIFont(name: nil, size:18.0)
                tiptLabel.textColor = UIColor.blackColor()
                tiptLabel.textAlignment = NSTextAlignment.Left
                self.view.addSubview(tiptLabel)
                
                
                var textView = UITextView()
                textView.frame = CGRectMake(15.0, 150.0, 300.0, 60.0)
                textView.text = des
                textView.font = UIFont(name:nil, size:18.0)
                textView.textColor = UIColor.blackColor()
                textView.textAlignment = NSTextAlignment.Left
                self.view.addSubview(textView)
                
                
                
                var backButton = UIButton()
                backButton.frame = CGRectMake(250,440,60,15)
                backButton.backgroundColor = UIColor(red: CGFloat(255)/255.0, green: CGFloat(200)/255.0, blue: CGFloat(200)/255.0, alpha: 1.0)
                backButton.setTitle("Back", forState:.Normal)
                backButton.titleLabel.font = UIFont.systemFontOfSize(12)
                backButton.addTarget(self, action: "turnback",forControlEvents:.TouchUpInside)
                self.view.addSubview(backButton)
                
                
            }
        })
    }
    
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
       
        
        
        
        
        
        func ios8()->Bool{
            return UIDevice.currentDevice().systemVersion == "8.0"
        }
        
        
        //地理位置发生变化会回传，返回可空数组
        func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
            var location:CLLocation = locations[locations.count-1] as CLLocation
            //看看是否复合我们的标准
            if(location.horizontalAccuracy>0){
                println("经纬度:\t")
                println(location.coordinate.latitude)
                println(location.coordinate.longitude)
                self.countrycity = "\(location.coordinate.longitude-21 )" + ",\(location.coordinate.latitude-3.4)"
                loaddata(countrycity)
                
                
                locationManger.stopUpdatingLocation()//回值之后借宿定位
            }
        }
        //
        func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
            println(error)
        }
    func turnback(){
        //var View = ViewController()
        //self.presentViewController(View , animated: true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

