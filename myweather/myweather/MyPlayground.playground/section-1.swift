// Playground - noun: a place where people can play

import Cocoa


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