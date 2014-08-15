//
//  HttpController.swift
//  数据获取
//
//  Created by mohoo on 14-8-15.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//



import UIKit
protocol HttpProtocol{
    func didReceiveResults(results:NSDictionary)
}
class HttpController:NSObject{
    var delegate:HttpProtocol?
    func onSearch(url:String){
        var nsUrl:NSURL = NSURL(string:url)
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data: NSData!, error:NSError!) -> Void in
            var jsonResult:NSDictionary=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary//数据意见接搜
            self.delegate?.didReceiveResults(jsonResult)
            })
       }
    }
