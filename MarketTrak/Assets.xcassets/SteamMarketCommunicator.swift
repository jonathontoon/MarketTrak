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
    
    func searchMarketPlace(search: MTSearch) {
        
        var searchURL = "http://steamcommunity.com/market/search/render?q="
            searchURL += search.query!
            searchURL += search.collection!.urlArgument()
            searchURL += search.category!.urlArgument()
            searchURL += search.exterior!.urlArgument()
            searchURL += search.professionalPlayer!.urlArgument()
            searchURL += search.quality!.urlArgument()
            searchURL += search.stickerCategory!.urlArgument()
            searchURL += search.stickerCollection!.urlArgument()
            searchURL += search.team!.urlArgument()
            searchURL += search.tournament!.urlArgument()
            searchURL += search.type!.urlArgument()
            searchURL += search.weapon!.urlArgument()
            searchURL += "&start="+search.start.description
            searchURL += "&count="+search.count.description
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
                        
                        for node in doc.body!.css("div.market_listing_row") {
                            
                            if let innnerDoc = Kanna.HTML(html: node.innerHTML!, encoding: NSUTF8StringEncoding) {
          
                                let listingItem = MTListingItem()
                                
                                //Image 
                                if let imageNode = innnerDoc.at_css("img.market_listing_item_img") {
                                    let img = imageNode["srcset"]!.componentsSeparatedByString("1x,")[1]
                                    
                                    let stringLength = img.characters.count
                                    let substringIndex = stringLength - 3
                                    
                                    listingItem.image = NSURL(string: img.substringToIndex(img.startIndex.advancedBy(substringIndex)).stringByReplacingOccurrencesOfString("62f", withString: "500f"))
                                }
                                
                                //Price
                                listingItem.price = String(unescapeSpecialCharacters: node.css("div.market_listing_their_price span.market_table_value").text).stringByReplacingOccurrencesOfString("Starting at:", withString: "")
                                
                                // Number of items
                                listingItem.quantity = Int(String(unescapeSpecialCharacters: node.css("span.market_listing_num_listings_qty").text))
                                
                                //Title
                                listingItem.name = node.at_css("span.market_listing_item_name")!.text!
                                
                                //Color
                                if let colorNode = innnerDoc.at_css("span.market_listing_item_name") {
                                    var color = colorNode["style"]
                                    color = color!.componentsSeparatedByString("#")[1]
                                    
                                    let stringLength = color!.characters.count
                                    let substringIndex = stringLength - 1
                                    color = "#"+color!.substringToIndex(color!.startIndex.advancedBy(substringIndex))
                                    
                                    listingItem.color = color
                                    
                                }
                                
                                dump(listingItem)
                            }
                        }
                    }
                }
                
            }
        )
        
    }
}
