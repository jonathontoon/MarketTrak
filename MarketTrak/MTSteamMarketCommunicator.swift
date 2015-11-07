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
    var itemDatabase: NSDictionary!
    
    override init() {
        
        if let path = NSBundle.mainBundle().pathForResource("ItemsDatabase", ofType: "json")
        {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                do {
                    itemDatabase = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                } catch let error as NSError {
                    print("json error: \(error.localizedDescription)")
                }
                
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
        }
    }
    
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
            searchURL += "&language=english"
        
        var searchResults: [MTListingItem] = []
        
        getJSONFromURL(
            url: searchURL,
            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                if error == nil {
                
                    if let dataFromJSON = data {
                        
                        let json = JSON(data: dataFromJSON)
                        
                        if json.description != "null" {
                        
                            if let doc = Kanna.HTML(html: json["results_html"].stringValue, encoding: NSUTF8StringEncoding) {
                                
                                for node in doc.body!.css("a.market_listing_row_link") {
                                    
                                    if let innerDoc = Kanna.HTML(html: node.innerHTML!, encoding: NSUTF8StringEncoding) {
                  
                                        let listingItem = MTListingItem()
                                        
                                        // Image URL
                                        if let imageNode = innerDoc.at_css("img.market_listing_item_img") {
                                            let img = imageNode["srcset"]!.componentsSeparatedByString("1x,")[1]
                                            
                                            let stringLength = img.characters.count
                                            let substringIndex = stringLength - 3
                                            
                                            var stringURL: String = img.substringToIndex(img.startIndex.advancedBy(substringIndex))
                                                stringURL = stringURL.stringByReplacingOccurrencesOfString(" ", withString: "")
                                                stringURL = stringURL.stringByReplacingOccurrencesOfString("62f", withString: "512f")
                                            
                                            listingItem.imageURL = NSURL(string: stringURL)
                                        }
                                        
                                        // Item URL
                                        if let itemURL = node["href"] {
                                            listingItem.itemURL = NSURL(string: itemURL)
                                        }
                                        
                                        // Price
                                        listingItem.price = String(unescapeSpecialCharacters: node.css("div.market_listing_their_price span.market_table_value").text).stringByReplacingOccurrencesOfString("Starting at:", withString: "")
                                        
                                        // Number of items
                                        listingItem.quantity = Int(String(unescapeSpecialCharacters: node.css("span.market_listing_num_listings_qty").text))
                                        
                                        //Full Name
                                        listingItem.fullName = node.at_css("span.market_listing_item_name")!.text!
                                        
                                        //Exterior
                                        listingItem.exterior = determineExterior(listingItem.fullName)
                                        
                                        //Weapon
                                        listingItem.weapon = determineWeapon(listingItem.fullName)
                                        
                                        //Type
                                        listingItem.type = determineType(listingItem.fullName)
                                        
                                        // Skin Name
                                        if listingItem.type != Type.Sticker && listingItem.type != Type.Container && listingItem.type != Type.Tool && listingItem.type != Type.Tag && listingItem.type != Type.Pass && listingItem.type != Type.MusicKit && listingItem.type != Type.Gift && listingItem.type != Type.Key && listingItem.type != Type.None {
                                            
                                            if determineItemName(listingItem.fullName).componentsSeparatedByString(" | ").count > 1 {
                                                listingItem.itemName = determineItemName(listingItem.fullName).componentsSeparatedByString(" | ")[1]
                                            } else {
                                                listingItem.itemName = determineItemName(listingItem.fullName)
                                            }
                                            
                                        } else if listingItem.type == Type.Sticker {
                                        
                                            listingItem.itemName = determineItemName(listingItem.fullName).componentsSeparatedByString(" | ")[1]
                                            
                                        } else {
                                            
                                            listingItem.itemName = determineItemName(listingItem.fullName)
                                        
                                        }
                                        
                                        //Category
                                        listingItem.category = determineCategory(listingItem.fullName)
                                        
                                        //Collection
                                        if listingItem.type != Type.Sticker && listingItem.type != Type.Container && listingItem.type != Type.MusicKit && listingItem.type != Type.Tool && listingItem.type != Type.Tag && listingItem.type != Type.Pass && listingItem.type != Type.Gift && listingItem.type != Type.Key && listingItem.type != Type.None {
                                            
                                            if let weapons = self.itemDatabase["weapons"] {
                                                
                                                if let weapon = weapons[listingItem.weapon!.stringDescription()] {
                                                    
                                                    if let skins = weapon!["skins"] {
                                                        
                                                        for index in 0..<skins!.count {
                                                            
                                                            if skins![index]["name"] as! String == listingItem.itemName {
                                                                listingItem.collection = determineCollection((skins![index]["collection"] as? String)!)
                                                                listingItem.quality = determineQuality(skins![index]["quality"] as? String)
                                                                break
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }

                                        } else if listingItem.type == Type.Sticker {
                                        
                                            if let stickers = self.itemDatabase["stickers"] {
                                                
                                                for index in 0..<stickers.count {
                                                    
                                                    if stickers[index]["name"] as! String == listingItem.itemName {
                                                        
                                                        listingItem.stickerCollection = determineStickerCollection((stickers[index]["collection"] as? String)!)
                                                        listingItem.quality = determineQuality(stickers[index]["quality"] as? String)
                                                        break
                                                    }
                                                    
                                                }
                                            
                                            }
                                            
                                        } else if listingItem.type == Type.Container {
                                            
                                            if let containers = self.itemDatabase["containers"] {
                                                
                                                for index in 0..<containers.count {
                                                    
                                                    if containers[index]["name"] as! String == listingItem.itemName {
                                                                                                                
                                                        listingItem.collection = determineCollection((containers[index]["collection"] as? String)!)
                                                        listingItem.containedItems = containers[index]["items"] as? NSArray
                                                        listingItem.quality = determineQuality(containers[index]["quality"] as? String)
                                                        break
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        } else if listingItem.type == Type.Pass {
                                          
                                            if let pass = self.itemDatabase["pass"] {
                                                
                                                for index in 0..<pass.count {
                                                    
                                                    if pass[index]["name"] as? String == listingItem.fullName {
                                                        
                                                        if let usage = pass[index]["usage"] as? String {
                                                            listingItem.usage = usage
                                                            listingItem.quality = determineQuality(pass[index]["quality"] as? String)
                                                            listingItem.collection = determineCollection(pass[index]["collection"] as! String)
                                                            break
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        } else if listingItem.type == Type.Gift {
                                        
                                            if let gift = self.itemDatabase["gifts"] {
                                                
                                                for index in 0..<gift.count {
                                                    
                                                    if gift[index]["name"] as? String == listingItem.fullName {
                                                        
                                                        if let usage = gift[index]["usage"] as? String {
                                                            listingItem.usage = usage
                                                            listingItem.quality = determineQuality(gift[index]["quality"] as? String)
                                                            listingItem.collection = determineCollection(gift[index]["collection"] as! String)
                                                            break
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        } else {
                                            
                                            listingItem.collection = Collection.None
                                        
                                        }
                                        
                                        // Tournament
                                        if listingItem.type == Type.Sticker {
                                            
                                            if let stickers = self.itemDatabase["stickers"] {
                                                
                                                for index in 0..<stickers.count {
                                                   
                                                    if stickers[index]["collection"] as? String == listingItem.stickerCollection?.stringDescription() {
                                                        
                                                        if (stickers[index]["tournament"] as? String) != nil {
                                                            let tournamentObject: Tournament = determineTournament((stickers[index]["tournament"] as? String)!)
                                                            listingItem.tournament = tournamentObject
                                                            break
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        } else if listingItem.type == Type.Container {
                                            
                                            if let containers = self.itemDatabase["containers"] {
                                                
                                                for index in 0..<containers.count {
                                                    
                                                    if containers[index]["name"] as? String == listingItem.fullName {
                                                        
                                                        if let tournament = containers[index]["tournament"] as? String {
                                                            let tournamentObject: Tournament = determineTournament(tournament)
                                                            listingItem.tournament = tournamentObject
                                                            break
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                  
                                        // Item Usage
                                        if listingItem.type == Type.Key {
                                            
                                            if let keys = self.itemDatabase["keys"] {
                                                
                                                for index in 0..<keys.count {
                                                    
                                                    if keys[index]["name"] as? String == listingItem.fullName {
                                                        
                                                        if let usage = keys[index]["usage"] as? String {
                                                            listingItem.usage = usage
                                                            listingItem.quality = determineQuality(keys[index]["quality"] as? String)
                                                            break
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        } else if listingItem.type == Type.Tag {
                                            
                                            if let tag = self.itemDatabase["tag"] {
                                                listingItem.usage = tag["usage"] as? String
                                                listingItem.quality = determineQuality(tag["quality"] as? String)
                                            }
                                            
                                        } else if listingItem.type == Type.Tool {
                                            
                                            if let tool = self.itemDatabase["tool"] {
                                                listingItem.usage = tool["usage"] as? String
                                                listingItem.quality = determineQuality(tool["quality"] as? String)
                                                listingItem.category = Category.None
                                                listingItem.itemName = tool["name"] as? String
                                            }
                                            
                                        }
                                        
                                        // Artist Name
                                        if listingItem.type == Type.MusicKit {
                                            
                                            if let musickits = self.itemDatabase["musickits"] {
                                                
                                                for index in 0..<musickits.count {
                                                    
                                                    if musickits[index]["name"] as? String == listingItem.itemName {
                                                        
                                                        print(musickits[index]["artist"])
                                                        
                                                        if let artist = musickits[index]["artist"] as? String {
                                                            listingItem.artist = artist
                                                            listingItem.quality = determineQuality(musickits[index]["quality"] as? String)
                                                            break
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                        searchResults.append(listingItem)
                                        dump(listingItem)
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
        
            //itemName
            largeItem.itemName = searchResultItem.itemName
        
            //Price
            largeItem.price = searchResultItem.price
        
            //Image
            largeItem.imageURL = NSURL(string: searchResultItem.imageURL.absoluteString.stringByReplacingOccurrencesOfString("32f", withString: "160f"))
        
            //Exterior
            largeItem.exterior = searchResultItem.exterior
            
            //Weapon
            largeItem.weapon = searchResultItem.weapon
            
            //Type
            largeItem.type = searchResultItem.type
            
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
