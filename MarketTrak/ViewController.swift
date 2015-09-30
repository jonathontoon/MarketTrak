//
//  ViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 9/30/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    var json: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSONFromURL(
            url: "http://steamcommunity.com/market/listings/730/AK-47%20%7C%20Redline%20%28Field-Tested%29/render?start=0&count=10&currency=1&language=english&format=json",
            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                print("hi")
                
                if let dataFromJSON = data {
                    self.json = JSON(data: dataFromJSON)
                }
                
                
                print(self.json["results_html"].stringValue)
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getJSONFromURL(url urlString: String!, withCompletion:(data: NSData?, response: NSURLResponse?, error: NSError?) -> ()) {
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: withCompletion)
            task.resume()
        
    }
}

