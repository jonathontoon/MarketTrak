//
//  MTSteamMarketCommunicator.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/3/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kanna
import SDWebImage

extension String {
    
    init(unescapeSpecialCharacters: String!) {
        self = unescapeSpecialCharacters.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
}

protocol MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTListingItem]!)
    
}

class MTSteamMarketCommunicator: NSObject {
    
    var delegate: MTSteamMarketCommunicatorDelegate!
    
    func getJSONFromURL(url urlString: String!, withCompletion:(data: NSData?, response: NSURLResponse?, error: NSError?) -> ()) {
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: withCompletion)
        task.resume()
        
    }
    
    func getResultsForSearch(search: MTSearch) {
        
        var searchURL = "http://steamcommunity.com/market/search/render?query="
            searchURL += search.query!
            searchURL += "&appid=730"
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
        
        var searchResults: [MTListingItem] = []
        
        getJSONFromURL(
            url: searchURL,
            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                if let dataFromJSON = data {
                    let json = JSON(data: dataFromJSON)
                    
                    if let doc = Kanna.HTML(html: json["results_html"].stringValue, encoding: NSUTF8StringEncoding) {
                        
                        for node in doc.body!.css("div.market_listing_row") {
                            
                            if let innnerDoc = Kanna.HTML(html: node.innerHTML!, encoding: NSUTF8StringEncoding) {
          
                                let listingItem = MTListingItem()
                                
                                //Image 
                                if let imageNode = innnerDoc.at_css("img.market_listing_item_img") {
                                    let img = imageNode["srcset"]!.componentsSeparatedByString("1x,")[1]
                                    
                                    let stringLength = img.characters.count
                                    let substringIndex = stringLength - 3
                                    
                                    var stringURL: String = img.substringToIndex(img.startIndex.advancedBy(substringIndex))
                                        stringURL = stringURL.stringByReplacingOccurrencesOfString(" ", withString: "")
                                        stringURL = stringURL.stringByReplacingOccurrencesOfString("62f", withString: "30f")
                                    
                                    let tempImageView = UIImageView()
                                        tempImageView.sd_setImageWithURL(
                                            NSURL(string: stringURL),
                                            placeholderImage: UIImage()
                                        )
                                    
                                    listingItem.imageView = tempImageView
                                }
                                
                                //Price
                                listingItem.price = String(unescapeSpecialCharacters: node.css("div.market_listing_their_price span.market_table_value").text).stringByReplacingOccurrencesOfString("Starting at:", withString: "")
                                
                                // Number of items
                                listingItem.quantity = Int(String(unescapeSpecialCharacters: node.css("span.market_listing_num_listings_qty").text))
                                
                                //Title
                                listingItem.name = node.at_css("span.market_listing_item_name")!.text!
                                
                                //Exterior
                                listingItem.exterior = determineExterior(listingItem.name)
                                
                                //Weapon
                                listingItem.weapon = determineWeapon(listingItem.name)
                                
                                //Type
                                listingItem.type = determineType(listingItem.name)
                                
                                //Text Color
                                if let colorNode = innnerDoc.at_css("span.market_listing_item_name") {
                                    var color = colorNode["style"]
                                    color = color!.componentsSeparatedByString("#")[1]
                                    
                                    let stringLength = color!.characters.count
                                    let substringIndex = stringLength - 1
                                    color = "#"+color!.substringToIndex(color!.startIndex.advancedBy(substringIndex))
                                    
                                    listingItem.textColor = color
                                    
                                }
                                
                                //Category
                                listingItem.category = determineCategory(listingItem.textColor!, name: listingItem.name)
                                
                                searchResults.append(listingItem)
                            }
                        }
                        
                        if let delegate = self.delegate {
                            
                            delegate.searchResultsReturnedSuccessfully(searchResults)
                            
                        }
                    }
                }
                
            }
        )

    }
}
