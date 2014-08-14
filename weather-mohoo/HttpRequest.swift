//
//  HttpRequest.swift
//  weather-practice
//
//  Created by hy on 14-8-11.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//

import Foundation
import UIKit

class HttpRequest:NSObject{
    
    init()
    {
        super.init();
    }
    class func requestWithURL(urlString:String,completionHandler:(data:AnyObject)->Void)
    {
        var URL = NSURL.URLWithString(urlString)
        var req = NSURLRequest(URL: URL)
        var queue = NSOperationQueue();
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
            if error
            {
                dispatch_async(dispatch_get_main_queue(),
                    {
                        println(error)
                        completionHandler(data:NSNull())
                    })
            }
            else
            {
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                dispatch_async(dispatch_get_main_queue(),
                    {
                        completionHandler(data:jsonData)
                        
                    })
            }
            })
    }
    
    
    
}


