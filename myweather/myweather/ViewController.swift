//
//  ViewController.swift
//  myweather
//
//  Created by mohoo on 14-8-14.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func button(sender:AnyObject){
        println("click ")
        loadweather()
    }
    @IBOutlet  var tv:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //loadweather()
        self.view.backgroundColor = UIColor.blueColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadweather(){
        self.view.backgroundColor = UIColor.blueColor()
    
    var url = NSURL(string: "http://www.weather.com.cn/data/sk/101010100.html")
    //获取值并进行转换
    var data = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingUncached, error: nil)
    //var str = NSString(data: data, encoding: NSUTF8StringEncoding)//查看数据里面的内容
    
    //println(str)
    //解析数据
    var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
    var weatherInfo: AnyObject! = json.objectForKey("weatherinfo")
    var city: AnyObject! = weatherInfo.objectForKey("city")
    var wind:AnyObject! = weatherInfo.objectForKey("WD")
    var temp:AnyObject! = weatherInfo.objectForKey("temp")
       tv.text = "温度:\(temp)\n城市:\(city)\n风:\(wind)"
    }

}

