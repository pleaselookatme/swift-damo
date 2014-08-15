//
//  ViewController.swift
//  SurfInternet
//
//  Created by mohoo on 14-8-15.
//  Copyright (c) 2014年 mohoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var UrlInput: UITextField!
    @IBOutlet weak var GOsurf: UIButton!
    @IBOutlet weak var webDisplay: UIWebView!
    @IBAction func GOtoWeb(sender: AnyObject) {
        
        webDisplay.loadRequest(NSURLRequest(URL: NSURL(string: UrlInput.text)))
        
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

