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
    
    func urlEncode() -> CFString {
        return CFURLCreateStringByAddingPercentEscapes(
            nil,
            self,
            nil,
            "!*'();:@&=+$,/?%#[]",
            CFStringBuiltInEncodings.UTF8.rawValue
        )
    }
    
}

@objc protocol MTSteamMarketCommunicatorDelegate {
    
    optional func searchResultsReturnedSuccessfully(searchResults: [MTListingItem]!)
    optional func largeItemResultReturnedSuccessfully(largeItemResult: MTLargeItem!)
    
}

class MTSteamMarketCommunicator: NSObject {
    
    var delegate: MTSteamMarketCommunicatorDelegate!
    
    func getJSONFromURL(url urlString: String!, withCompletion:(data: NSData?, response: NSURLResponse?, error: NSError?) -> ()) {
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: withCompletion)
        task.resume()
        
    }
    
    func getHTMLFromURL(url urlString: String!, withCompletion:(htmlString: String?) -> ()) {
        
        if let myURL = NSURL(string: urlString) {
            
            do {
                
                let htmlString: String? = try String(contentsOfURL: myURL, encoding: NSUTF8StringEncoding)
                return withCompletion(htmlString: htmlString)
                
            } catch {
                print("Error: No HTML :(")
            }

        } else {
            print("Error: \(urlString) doesn't seem to be a valid URL")
        }
        
    }
    
    func getResultsForSearch(search: MTSearch) {
        
        print("getResultsForSearch")
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var searchURL = "http://steamcommunity.com/market/search/render?query="
            searchURL += search.query!
            searchURL = searchURL.stringByReplacingOccurrencesOfString(" ", withString: "%20")
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
                
                if error == nil {
                
                    if let dataFromJSON = data {
                        
                        let json = JSON(data: dataFromJSON)
                        
                        if json.description != "null" {
                        
                            if let doc = Kanna.HTML(html: json["results_html"].stringValue, encoding: NSUTF8StringEncoding) {
                                
                                for node in doc.body!.css("div.market_listing_row") {
                                    
                                    if let innerDoc = Kanna.HTML(html: node.innerHTML!, encoding: NSUTF8StringEncoding) {
                  
                                        let listingItem = MTListingItem()
                                        
                                        //Image 
                                        if let imageNode = innerDoc.at_css("img.market_listing_item_img") {
                                            let img = imageNode["srcset"]!.componentsSeparatedByString("1x,")[1]
                                            
                                            let stringLength = img.characters.count
                                            let substringIndex = stringLength - 3
                                            
                                            var stringURL: String = img.substringToIndex(img.startIndex.advancedBy(substringIndex))
                                                stringURL = stringURL.stringByReplacingOccurrencesOfString(" ", withString: "")
                                                stringURL = stringURL.stringByReplacingOccurrencesOfString("62f", withString: "32f")
                                            
                                            listingItem.imageURL = NSURL(string: stringURL)
                                        }
                                        
                                        //Price
                                        listingItem.price = String(unescapeSpecialCharacters: node.css("div.market_listing_their_price span.market_table_value").text).stringByReplacingOccurrencesOfString("Starting at:", withString: "")
                                        
                                        // Number of items
                                        listingItem.quantity = Int(String(unescapeSpecialCharacters: node.css("span.market_listing_num_listings_qty").text))
                                        
                                        //Full Name
                                        listingItem.fullName = node.at_css("span.market_listing_item_name")!.text!
                                        
                                        // Skin Name
                                        listingItem.skinName = determineSkinName(listingItem.fullName)
                                        
                                        //Exterior
                                        listingItem.exterior = determineExterior(listingItem.fullName)
                                        
                                        //Weapon
                                        listingItem.weapon = determineWeapon(listingItem.fullName)
                                        
                                        //Type
                                        listingItem.type = determineType(listingItem.fullName)
                                        
                                        //Text Color
                                        if let colorNode = innerDoc.at_css("span.market_listing_item_name") {
                                            var color = colorNode["style"]
                                            color = color!.componentsSeparatedByString("#")[1]
                                            
                                            let stringLength = color!.characters.count
                                            let substringIndex = stringLength - 1
                                            color = "#"+color!.substringToIndex(color!.startIndex.advancedBy(substringIndex))
                                            
                                            listingItem.textColor = color
                                            
                                        }
                                        
                                        //Category
                                        listingItem.category = determineCategory(listingItem.textColor!, name: listingItem.fullName)
                                        
                                        //Collection
                                        listingItem.collection = determineCollection(listingItem.skinName)
                                        
                                        searchResults.append(listingItem)
                                    }
                                }
                                
                                if let delegate = self.delegate {
                                    
                                    delegate.searchResultsReturnedSuccessfully!(searchResults)
                                    
                                }
                            }
                        
                        } else {
                        
                            print("API returned NULL")
                            
                        }
                    }
                
                } else {
                
                    print(error)
                    
                }
            }
        )

    }
    
    func getResultsForItem(searchResultItem: MTListingItem!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var itemURL = "http://steamcommunity.com/market/listings/730/"
            itemURL += searchResultItem.fullName!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
            itemURL = itemURL.stringByReplacingOccurrencesOfString("(", withString: "%28")
            itemURL = itemURL.stringByReplacingOccurrencesOfString(")", withString: "%29")
            itemURL += "/render?start=0&count=2&currency=1&language=english"
        
        let largeItem = MTLargeItem()
        
            //FullName
            largeItem.fullName = searchResultItem.fullName
        
            //SkinName
            largeItem.skinName = searchResultItem.skinName
        
            //Price
            largeItem.price = searchResultItem.price
        
            //Image
            largeItem.imageURL = NSURL(string: searchResultItem.imageURL.absoluteString.stringByReplacingOccurrencesOfString("32f", withString: "512f"))
        
            //Exterior
            largeItem.exterior = searchResultItem.exterior
            
            //Weapon
            largeItem.weapon = searchResultItem.weapon
            
            //Type
            largeItem.type = searchResultItem.type
            
            //TextColor
            largeItem.textColor = searchResultItem.textColor
            
            //Category
            largeItem.category = searchResultItem.category
        
            //Collection
            largeItem.collection = searchResultItem.collection
        
        getJSONFromURL(
            url: itemURL,
            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                if error == nil {
                    
                    if let dataFromJSON = data {
                        
                        let json = JSON(data: dataFromJSON)
                        
                        if json.description != "null" {
                        
                            for itemObject in json["assets"]["730"]["2"] {
                                
                                let item = itemObject.1 as JSON
                                print(item)
                                
                                //Quality
                                largeItem.quality = determineQuality(item["type"].stringValue)
                                
                                //ItemDescription
                                if largeItem.weapon != Weapon.None {
                                    
                                    if largeItem.type == Type.Sticker {
                                    
                                        if largeItem.category == Category.Souvenir {
                                            largeItem.itemDescription = item["descriptions"][item["descriptions"].count-9]["value"].stringValue
                                            largeItem.itemDescription = largeItem.itemDescription + " " + item["descriptions"][item["descriptions"].count-7]["value"].stringValue
                                            largeItem.itemDescription = largeItem.itemDescription + " \n " + item["descriptions"][item["descriptions"].count-5]["value"].stringValue
                                        } else {
                                            largeItem.itemDescription = item["descriptions"][item["descriptions"].count-5]["value"].stringValue
                                        }
                                        
                                    } else if largeItem.type == Type.Knife {
                                    
                                        largeItem.itemDescription = item["descriptions"][item["descriptions"].count-2 ]["value"].stringValue
                                        
                                    } else {
                                        
                                        largeItem.itemDescription = item["descriptions"][item["descriptions"].count-4]["value"].stringValue
                                    
                                    }
                                }
                                
                            }
                            
                            if let delegate = self.delegate {
                                
                                delegate.largeItemResultReturnedSuccessfully!(largeItem)
                                
                            }

                        } else {
                            
                            print("API returned NULL")
                            
                        }
                    }
                    
                } else {
                    
                    print(error)
                    
                }
            }
        )
        
    }
}
