//
//  SteamMarketCommunicator.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/3/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kanna

class SteamMarketCommunicator {
    
    func getJSONFromURL(url urlString: String!, withCompletion:(data: NSData?, response: NSURLResponse?, error: NSError?) -> ()) {
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: withCompletion)
        task.resume()
        
    }
    
    func searchMarketPlace(searchQuery: MTSearchQuery) {
        
        var searchURL = "http://steamcommunity.com/market/search/render?q="
            searchURL += searchQuery.query!
            searchURL += searchQuery.collection!.urlArgument()
            searchURL += searchQuery.category!.urlArgument()
            searchURL += searchQuery.exterior!.urlArgument()
            searchURL += searchQuery.professionalPlayer!.urlArgument()
            searchURL += searchQuery.quality!.urlArgument()
            searchURL += searchQuery.stickerCategory!.urlArgument()
            searchURL += searchQuery.stickerCollection!.urlArgument()
            searchURL += searchQuery.team!.urlArgument()
            searchURL += searchQuery.tournament!.urlArgument()
            searchURL += searchQuery.type!.urlArgument()
            searchURL += searchQuery.weapon!.urlArgument()
            searchURL += "&start="+searchQuery.start.description
            searchURL += "&count="+searchQuery.count.description
            searchURL += "&appid=730"
        
        print(searchURL)
        
        getJSONFromURL(
            url: searchURL,
            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                if let dataFromJSON = data {
                    let json = JSON(data: dataFromJSON)
                    
                    //print(self.json)
                    
                    if let doc = Kanna.HTML(html: json["results_html"].stringValue, encoding: NSUTF8StringEncoding) {
                        print(json["results_html"].stringValue)
                        
//                        for node in doc.body!.css("div.market_listing_row") {
//                            
//                            print(String(unescapeSpecialCharacters: node.css("div.market_listing_their_price span.market_listing_price_with_fee").text))
//                            print(node.css("span.market_listing_item_name").text)
//                        }
                    }
                }
                
            }
        )
        
    }
}
