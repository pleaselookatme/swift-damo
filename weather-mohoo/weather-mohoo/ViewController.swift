//
//  ViewController.swift
//  weather-mohoo
//
//  Created by hy on 14-8-11.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet weak var reminder: UILabel!
    @IBOutlet weak var LoadingPlayer: UIActivityIndicatorView!
    let locationManger:CLLocationManager = CLLocationManager()
     var indexInfo = NSDictionary()
    var countrycity :NSString = ""//"116.305145,39.982368"
    var results = NSArray()
    var currentdate = String()
    var currentCity = String()
    var pm25data = String()
    var topimage = UIImageView(frame:CGRect(x: 0, y: 0, width: 320, height: 480))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.8, alpha: 0.2)
        var refreshControl = UIRefreshControl()
        //refreshControl.attributedTitle = "下拉。。。刷新"
        //refreshControl.addTarget(self, action: loaddata(countrycity), forControlEvents: <#UIControlEvents#>)
        
        
        self.topimage.image = UIImage(named:"bg0_fine_day.jpg")
        self.view.addSubview(topimage)
        self.LoadingPlayer.startAnimating()
        locationManger.delegate = self
       // locationManger.desiredAccuracy=kCLLocationAccuracyHundredMeters
        locationManger.desiredAccuracy = kCLLocationAccuracyBest//精度
        
        if(ios8()){
            locationManger.requestAlwaysAuthorization()
        }
        locationManger.startUpdatingLocation()
        setupSwipeGuestured()
        
        
    }
    
    
    func loaddata(countrycity:NSString){
        self.LoadingPlayer.stopAnimating()
        self.reminder.text = nil
        self.LoadingPlayer.hidden = true
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
                
                //设施各项指数内容
                //设置按钮
                var index = self.results[0].objectForKey("index") as NSArray
                var count = index.count

                var zhishubutton0 = UIButton()
                zhishubutton0.frame = CGRectMake(CGFloat(30),CGFloat(25 + 300),130,40)
                zhishubutton0.backgroundColor = UIColor(red: CGFloat(93)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(150)/255.0, alpha: 0.3)
                
                var tishides0 = index[0].objectForKey("des") as NSString
                
                var zhishuinformation0 = index[0].objectForKey("tipt") as NSString
                var zhishudegree0 = index[0].objectForKey("zs") as NSString
                zhishubutton0.setTitle("\(zhishuinformation0)\n\(zhishudegree0)", forState:.Normal)
                zhishubutton0.titleLabel.numberOfLines = 2
                zhishubutton0.titleLabel.textAlignment =  NSTextAlignment.Center
                zhishubutton0.titleLabel.font = UIFont.systemFontOfSize(12)
                zhishubutton0.addTarget(self, action: "disdetail0",forControlEvents:.TouchUpInside)
                self.view.addSubview(zhishubutton0)
                
                
                
                //洗车
                var zhishubutton1 = UIButton()
                zhishubutton1.frame = CGRectMake(CGFloat (165),CGFloat (25 + 300),130,40)
                zhishubutton1.backgroundColor = UIColor(red: CGFloat(93)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(150)/255.0, alpha: 0.3)
                
                var tishides1 = index[1].objectForKey("des") as NSString
                
                var zhishuinformation1 = index[1].objectForKey("tipt") as NSString
                var zhishudegree1 = index[1].objectForKey("zs") as NSString
                zhishubutton1.setTitle("\(zhishuinformation1)\n\(zhishudegree1)", forState:.Normal)
                zhishubutton1.titleLabel.numberOfLines = 2
                zhishubutton1.titleLabel.textAlignment =  NSTextAlignment.Center
                zhishubutton1.titleLabel.font = UIFont.systemFontOfSize(12)
                zhishubutton1.addTarget(self, action: "disdetail1",forControlEvents:.TouchUpInside)
                self.view.addSubview(zhishubutton1)
                
                //旅游
                var zhishubutton2 = UIButton()
                zhishubutton2.frame = CGRectMake(CGFloat (30),CGFloat (3 * 25) + 300,130,40)
                zhishubutton2.backgroundColor = UIColor(red: CGFloat(93)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(150)/255.0, alpha: 0.3)
                
                var tishides2 = index[2].objectForKey("des") as NSString
                
                var zhishuinformation2 = index[2].objectForKey("tipt") as NSString
                var zhishudegree2 = index[2].objectForKey("zs") as NSString
                zhishubutton2.setTitle("\(zhishuinformation2)\n\(zhishudegree2)", forState:.Normal)
                zhishubutton2.titleLabel.numberOfLines = 2
                zhishubutton2.titleLabel.textAlignment =  NSTextAlignment.Center
                zhishubutton2.titleLabel.font = UIFont.systemFontOfSize(12)
                zhishubutton2.addTarget(self, action: "disdetail2",forControlEvents:.TouchUpInside)
                self.view.addSubview(zhishubutton2)
                
                
                //感冒
                var zhishubutton3 = UIButton()
                zhishubutton3.frame = CGRectMake(CGFloat (165),CGFloat (3 * 25) + 300,130,40)
                zhishubutton3.backgroundColor = UIColor(red: CGFloat(93)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(150)/255.0, alpha: 0.3)
                
                var tishides3 = index[3].objectForKey("des") as NSString
                
                var zhishuinformation3 = index[3].objectForKey("tipt") as NSString
                var zhishudegree3 = index[3].objectForKey("zs") as NSString
                zhishubutton3.setTitle("\(zhishuinformation3)\n\(zhishudegree3)", forState:.Normal)
                zhishubutton3.titleLabel.numberOfLines = 2
                zhishubutton3.titleLabel.textAlignment =  NSTextAlignment.Center
                zhishubutton3.titleLabel.font = UIFont.systemFontOfSize(12)
                zhishubutton3.addTarget(self, action: "disdetail3",forControlEvents:.TouchUpInside)
                self.view.addSubview(zhishubutton3)
                
                
                //运动
                var zhishubutton4 = UIButton()
                zhishubutton4.frame = CGRectMake(CGFloat (30),CGFloat (5 * 25) + 300,130,40)
                zhishubutton4.backgroundColor = UIColor(red: CGFloat(93)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(150)/255.0, alpha: 0.3)
                
                var tishides4 = index[4].objectForKey("des") as NSString
                
                var zhishuinformation4 = index[4].objectForKey("tipt") as NSString
                var zhishudegree4 = index[4].objectForKey("zs") as NSString
                zhishubutton4.setTitle("\(zhishuinformation4)\n\(zhishudegree4)", forState:.Normal)
                zhishubutton4.titleLabel.numberOfLines = 2
                zhishubutton4.titleLabel.textAlignment =  NSTextAlignment.Center
                zhishubutton4.titleLabel.font = UIFont.systemFontOfSize(12)
                zhishubutton4.addTarget(self, action: "disdetail4",forControlEvents:.TouchUpInside)
                self.view.addSubview(zhishubutton4)
                
                
                
                //紫外线
                var zhishubutton5 = UIButton()
                zhishubutton5.frame = CGRectMake(CGFloat (165),CGFloat (5 * 25) + 300,130,40)
                zhishubutton5.backgroundColor = UIColor(red: CGFloat(93)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(150)/255.0, alpha: 0.3)
                
                var tishides5 = index[5].objectForKey("des") as NSString
                
                var zhishuinformation5 = index[5].objectForKey("tipt") as NSString
                var zhishudegree5 = index[5].objectForKey("zs") as NSString
                zhishubutton5.setTitle("\(zhishuinformation5)\n\(zhishudegree5)", forState:.Normal)
                zhishubutton5.titleLabel.numberOfLines = 2
                zhishubutton5.titleLabel.textAlignment =  NSTextAlignment.Center
                zhishubutton5.titleLabel.font = UIFont.systemFontOfSize(12)
                zhishubutton5.addTarget(self, action: "disdetail5",forControlEvents:.TouchUpInside)
                self.view.addSubview(zhishubutton5)
                
                //获取连续四天的天气情况
                var weather_data = self.results[0].objectForKey("weather_data") as NSArray
                
                
                
                //提取并放置日期、天气、温度、风向
                //data：日期
                //weather: 天气
                //temperature:温度
                //wind:风力
                var count_data = weather_data.count
                var controlView = ControlView()
                for i in 0..<count_data{
                    if i == 0{
                        var arr = Array<Character>()
                        var date = weather_data[i].objectForKey("date") as NSString
                        for j in "\(date)"{
                            arr += j
                        }
                        var timeweatherlabel = controlView.createLabelWithTitle("\(arr[14])\(arr[15])", n: 45)
                        timeweatherlabel.frame = CGRectMake(30, 100, 60, 60)
                        self.view.addSubview(timeweatherlabel)
                        
                        var sheshidulabel = controlView.createLabelWithTitle("\(arr[16])", n: 10)
                        sheshidulabel.frame = CGRectMake(80, 130, 30, 15)
                        self.view.addSubview(sheshidulabel)
                        
                        var datelabel = controlView.createLabelWithTitle("\(arr[0])\(arr[1])",n: 10)
                        datelabel.frame = CGRectMake(30, 220, 60, 15)
                        self.view.addSubview(datelabel)
                        
                        var weather = weather_data[i].objectForKey("weather") as NSString
                        var weatherlabel = controlView.createLabelWithTitle(weather, n: 20)
                        weatherlabel.frame = CGRectMake(100, 100, 60, 60)
                        self.view.addSubview(weatherlabel)
                        
                        
                    }else{
                        var date = weather_data[i].objectForKey("date") as NSString
                        var datelabel = controlView.createLabelWithTitle(date,n: 10)
                        datelabel.frame = CGRectMake(CGFloat(i)*70 + 30, 220, 60, 15)
                        self.view.addSubview(datelabel)
                    }
                    
                    
                    
                    var temperature = weather_data[i].objectForKey("temperature") as NSString
                    var templabel = controlView.createLabelWithTitle(temperature, n: 10)
                    templabel.frame = CGRectMake(CGFloat(i)*70 + 30, 200, 60, 15)
                    self.view.addSubview(templabel)
                    
                    var weather = weather_data[i].objectForKey("weather") as NSString
                    var weatherlabel = controlView.createLabelWithTitle(weather, n: 10)
                    weatherlabel.frame = CGRectMake(CGFloat(i)*70 + 30, 240, 60, 15)
                    self.view.addSubview(weatherlabel)
                    
                    
                    
                    
                    var wind = weather_data[i].objectForKey("wind") as NSString
                    var windlabel = controlView.createLabelWithTitle(wind, n: 10)
                    windlabel.frame = CGRectMake(CGFloat(i)*70 + 30, 260, 60, 15)
                    self.view.addSubview(windlabel)
                    
                    
                    //从网路获取并放置白天、晚上的气象图片
                    var dayPictureUrl = weather_data[i].objectForKey("dayPictureUrl") as NSString
                    var dayPictureImage = UIImageView()
                    dayPictureImage.frame = CGRectMake(CGFloat(i)*70 + 30, 170, 60, 30)
                    self.view.addSubview(dayPictureImage)
                    
                    let requestday = NSURLRequest(URL :NSURL.URLWithString(dayPictureUrl))
                    NSURLConnection.sendAsynchronousRequest(requestday, queue: NSOperationQueue.mainQueue(), completionHandler: { response, data, error in
                        if error {
                            println(error)
                            
                        } else {
                            let image = UIImage(data :data)
                            dispatch_async(dispatch_get_main_queue(), {
                                dayPictureImage.image = image
                                })
                        }
                        })
                    
                    
                    
                    var nightPictureUrl = weather_data[i].objectForKey("nightPictureUrl") as NSString
                    var nightPictureImage = UIImageView()
                    nightPictureImage.frame = CGRectMake(CGFloat(i)*70 + 30, 290, 60, 30)
                    self.view.addSubview(nightPictureImage)
                    
                    let requestnight = NSURLRequest(URL :NSURL.URLWithString(nightPictureUrl))
                    NSURLConnection.sendAsynchronousRequest(requestnight, queue: NSOperationQueue.mainQueue(), completionHandler: { response, data, error in
                        if error {
                            println(error)
                            
                        } else {
                            let image = UIImage(data :data)
                            dispatch_async(dispatch_get_main_queue(), {
                                nightPictureImage.image = image
                                })
                        }
                        })
                    
                }
                
                
                
                
                println(self.currentCity)
                println(self.currentdate)
                
                
                
                //调用setupview函数
                self.setupview()
                
            }
            
            
            
            })
    }
    
    
    //放置loaddata获取的数据
    func setupview(){
        
        var controlView = ControlView()
        
        var timelabel = controlView.createLabelWithTitle(self.currentdate,n: 10)
        timelabel.frame = CGRectMake(30, 30, 100, 30)
        self.view.addSubview(timelabel)
        
        var citylabel = controlView.createLabelWithTitle(self.currentCity,n: 10)
        citylabel.frame = CGRectMake(30, 45, 100, 35)
        self.view.addSubview(citylabel)
        
        var pm25label = controlView.createLabelWithTitle("PM2.5",n: 14)
        pm25label.frame = CGRectMake(210, 30, 100, 35)
        self.view.addSubview(pm25label)
        
        var pm25datalabel = controlView.createLabelWithTitle(pm25data,n: 25)
        pm25datalabel.frame = CGRectMake(230, 60, 50, 35)
        self.view.addSubview(pm25datalabel)
        
        
        
        
    }
    
    
   
    func disdetail0(){
        var detail = DetailViewController()
        detail.degree = 0
        self.presentViewController(detail, animated: true, completion: nil)
    }
    func disdetail1(){
        var detail = DetailViewController()
        detail.degree = 1
        self.presentViewController(detail, animated: true, completion: nil)
    }
    func disdetail2(){
        var detail = DetailViewController()
        detail.degree = 2
        self.presentViewController(detail, animated: true, completion: nil)
    }
    func disdetail3(){
        var detail = DetailViewController()
        detail.degree = 3
        self.presentViewController(detail, animated: true, completion: nil)
    }
    func disdetail4(){
        var detail = DetailViewController()
        detail.degree = 4
        self.presentViewController(detail, animated: true, completion: nil)
    }
    func disdetail5(){
        var detail = DetailViewController()
        detail.degree = 5
        self.presentViewController(detail, animated: true, completion: nil)
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    
    
    
    
    func ios8()->Bool{
        return UIDevice.currentDevice().systemVersion == "8.0"
    }
    
    //下拉刷新
    func setupSwipeGuestured(){
        let downSwipe = UISwipeGestureRecognizer(target: self, action: "swipeUp")
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(downSwipe)
    }
    func swipeUp(){
        self.LoadingPlayer.startAnimating()
        self.reminder.text = "努力加载ing..."
        self.LoadingPlayer.hidden = false
        locationManger.delegate = self
        locationManger.desiredAccuracy=kCLLocationAccuracyHundredMeters
        //locationManger.desiredAccuracy = kCLLocationAccuracyBest//精度
        
        if(ios8()){
            locationManger.requestAlwaysAuthorization()
        }
        locationManger.startUpdatingLocation()
        
        println("chulaile")
    }
    
    
    
    
    
    //地理位置发生变化会回传，返回可空数组
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[locations.count-1] as CLLocation
        //看看是否复合我们的标准
        if(location.horizontalAccuracy>0){
            println("经纬度:\t")
            println(location.coordinate.latitude)
            println(location.coordinate.longitude)
            self.countrycity = "\(location.coordinate.longitude-21 )" + ",\(location.coordinate.latitude-4)"
            loaddata(countrycity)
        
            
            locationManger.stopUpdatingLocation()//回值之后借宿定位
        }
    }
    //
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println(error)
         self.reminder.text = "地理位置不可用！"
    }
 
    
}

