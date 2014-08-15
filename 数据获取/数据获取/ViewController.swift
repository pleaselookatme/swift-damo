//
//  ViewController.swift
//  数据获取
//
//  Created by mohoo on 14-8-15.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HttpProtocol {
    var eHttp = HttpController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eHttp.delegate = self//当前类
        eHttp.onSearch("http://api.map.baidu.com/telematics/v3/weather?location=118,32%E5%8D%97%E4%BA%AC&output=json&ak=DCb2d6df5f7f732e4daeeadde7b2470c")//获取网页信息
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didReceiveResults(results: NSDictionary){
      println("$$$$$$$$$$$$$$$$$$$")//当调用ehttp的时候就会执行didreceiveResults函数内容
        println(results)
    }

}

