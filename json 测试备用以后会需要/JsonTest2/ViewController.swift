//
//  ViewController.swift
//  JsonTest2
//
//  Created by mohoo on 14-8-5.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
      var request = HTTPTask()
        request.GET("http://192.168.0.12/student/openapi.php?id=1&password=1", parameters: nil, success: {(response: HTTPResponse) -> Void in
            if response.responseObject {
                let data = response.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                
                
                let json = JSONValue(data)
                println(json)
                if let country = json["student"]["data"][1]["grade"].string {
                println(country)
                    println()
                    println()
                }else{
                println("================================")
                }
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError) -> Void in
                println("error: \(error)")
            })

        
        
        
  /*
        var request = HTTPTask()
        request.POST("http://domain.com/create", parameters: ["param": "hi", "something": "else", "key": "value"], success: {(response: HTTPResponse) -> Void in
            
            },failure: {(error: NSError) -> Void in
                println("============")
                
            })
*/
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

