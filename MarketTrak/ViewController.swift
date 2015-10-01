//
//  ViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 9/30/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kanna

class ViewController: UIViewController {

    var json: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSONFromURL(
            url: "http://steamcommunity.com/market/listings/730/AWP%20%7C%20Asiimov%20%28Field-Tested%29/render?start=0&count=100&currency=1&language=english&format=json",
            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                if let dataFromJSON = data {
                    self.json = JSON(data: dataFromJSON)
                    
                    if let doc = Kanna.HTML(html: self.json["results_html"].stringValue, encoding: NSUTF8StringEncoding) {
                        //print(self.json["results_html"].stringValue)
                        
                        for node in doc.body!.css("div.market_listing_row") {
                            print(node.css("div.market_listing_their_price span.market_listing_price_with_fee").text)
                            print(node.css("span.market_listing_item_name").text)
                        }
                    }
                }
                
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

