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
import CoreData

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
    
    func returnResultsForSearch(searchResults: [MTItem])
    optional func returnResultForItem(itemResult: MTItem)
    
}

class MTSteamMarketCommunicator: NSObject {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
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
        
        var searchResults: [MTItem] = []
        let searchURL = search.searchURL
        
        print(searchURL)
        
        getJSONFromURL(
            url: searchURL,
            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
            if error == nil {
            
                if let dataFromJSON = data {
                    
                    let json = JSON(data: dataFromJSON)
                    
                    if json.description != "null" {
                    
                        if let doc = Kanna.HTML(html: json["results_html"].stringValue, encoding: NSUTF8StringEncoding) {
                            
                            let listingNodes = doc.body!.css("a.market_listing_row_link")
                            
                            for node in listingNodes {
                                
                                    let fullName = node.at_css("span.market_listing_item_name")!.text!
                                
                                    let listingItem = MTItem()
                                    
                                    // Item URL
                                    if let itemURL = node["href"] {
                                        listingItem.itemURL = NSURL(string: itemURL + "?l=english&country=us")
                                    }
                                    
                                    // Price
                                    let priceString = String(unescapeSpecialCharacters: node.css("div.market_listing_their_price span.market_table_value span.normal_price").text).stringByReplacingOccurrencesOfString("$", withString: "").stringByReplacingOccurrencesOfString(" USD", withString: "")
                                    listingItem.currentPrice = MTCurrency(currency: NSNumber(float: Float(priceString)!))
                                
                                    // Quantity
                                    listingItem.quantity = Int(node.css("span.market_listing_num_listings_qty").text!.stringByReplacingOccurrencesOfString(",", withString: ""))
                                
                                    // Weapon
                                    listingItem.weaponType = determineWeapon(fullName)
                                    
                                    // Item Name
                                    listingItem.name = determineItemName(fullName)
                                    
                                    // Type
                                    listingItem.type = determineType(fullName)
                                
                                    // Category
                                    listingItem.category = determineCategory(fullName)
                                    
                                    // Exterior
                                    listingItem.exterior = determineExterior(fullName)
                                    
                                    let entityDescription: NSEntityDescription!
                                    let objects: [AnyObject]!
                                    var predicate: NSPredicate! = NSPredicate(format: "name ==[cd] %@ AND type ==[cd] %@", listingItem.name, listingItem.type.stringDescription())
                                    
                                    if listingItem.weaponType != nil && listingItem.weaponType != WeaponType.None {
                               
                                        predicate = NSPredicate(format: "name ==[cd] %@ AND type ==[cd] %@ AND weaponType ==[cd] %@", listingItem.name, listingItem.type.stringDescription(), listingItem.weaponType!.stringDescription())
                                    }
                                
                                    switch listingItem.type! {
                                        
                                        case Type.Key:
                                            
                                            entityDescription = NSEntityDescription.entityForName("Key", inManagedObjectContext: self.managedObjectContext)
                                            
                                        case Type.Sticker:
                                            
                                            entityDescription = NSEntityDescription.entityForName("Sticker", inManagedObjectContext: self.managedObjectContext)
                                            
                                        case Type.Tag:
                                            
                                            entityDescription = NSEntityDescription.entityForName("Tag", inManagedObjectContext: self.managedObjectContext)
                                            
                                        case Type.Tool:
                                            
                                            entityDescription = NSEntityDescription.entityForName("Tool", inManagedObjectContext: self.managedObjectContext)
                                            
                                        case Type.Pass:
                                            
                                            entityDescription = NSEntityDescription.entityForName("Pass", inManagedObjectContext: self.managedObjectContext)
                                            
                                        case Type.MusicKit:
                                            
                                            entityDescription = NSEntityDescription.entityForName("MusicKit", inManagedObjectContext: self.managedObjectContext)
                                            
                                        case Type.Gift:
                                            
                                            entityDescription = NSEntityDescription.entityForName("Gift", inManagedObjectContext: self.managedObjectContext)
                                            
                                        case Type.Container:
                                            
                                            entityDescription = NSEntityDescription.entityForName("Container", inManagedObjectContext: self.managedObjectContext)
                                        
                                        case Type.Collectable:
                                        
                                        entityDescription = NSEntityDescription.entityForName("Collectable", inManagedObjectContext: self.managedObjectContext)
                                        
                                        default:
                                            
                                            entityDescription = NSEntityDescription.entityForName("Weapon", inManagedObjectContext: self.managedObjectContext)
                                    }
                                    
                                    let fetchRequest = NSFetchRequest()
                                        fetchRequest.entity = entityDescription
                                        fetchRequest.predicate = predicate
                                
                                    do {
                                        objects = try self.managedObjectContext.executeFetchRequest(fetchRequest)
                                    } catch {
                                        objects = nil
                                        print("Failed")
                                    }
                                    
                                    if let results = objects {
                                        
                                        if results.count > 0 {
                                            
                                            var matchedObject: NSManagedObject!
                                            
                                            switch listingItem.type! {
                                                
                                                case Type.Key:
                                                    
                                                    matchedObject = results[0] as! Key
                                                    listingItem.name = matchedObject.valueForKey("name") as! String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.collection = matchedObject.valueForKey("collection") as? String
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                                    
                                                case Type.Gift:
                                                    
                                                    matchedObject = results[0] as! Gift
                                                    listingItem.name = matchedObject.valueForKey("name") as! String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.containerSeries = matchedObject.valueForKey("containerSeries") as? NSNumber
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                                    
                                                case Type.MusicKit:
                                                    
                                                    matchedObject = results[0] as! MusicKit
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.artistName = matchedObject.valueForKey("artistName") as? String
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                                    
                                                case Type.Pass:
                                                    
                                                    matchedObject = results[0] as! Pass
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.collection = matchedObject.valueForKey("collection") as? String
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                                    
                                                case Type.Tool:
                                                    
                                                    matchedObject = results[0] as! Tool
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                                    
                                                case Type.Container:
                                                    
                                                    matchedObject = results[0] as! Container
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.tournament = matchedObject.valueForKey("tournament") as? String
                                                    listingItem.collection = matchedObject.valueForKey("collection") as? String
                                                    listingItem.containerSeries = matchedObject.valueForKey("containerSeries") as? NSNumber
                                                    listingItem.stickerCollection = matchedObject.valueForKey("stickerCollection") as? String
                                                    
                                                    if let dataFromString = ("["+(matchedObject.valueForKey("items") as! String)+"]").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                                                        listingItem.items = JSON(data: dataFromString)
                                                        
                                                    }
                                                    
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.containerSeries = matchedObject.valueForKey("containerSeries") as? NSNumber
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                                
                                                case Type.Collectable:
                                                    
                                                    matchedObject = results[0] as! Collectable
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.collection = matchedObject.valueForKey("collection") as? String
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                               
                                                case Type.Sticker:
                                                    
                                                    matchedObject = results[0] as! Sticker
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.tournament = matchedObject.valueForKey("tournament") as? String
                                                    listingItem.stickerCollection = matchedObject.valueForKey("stickerCollection") as? String
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                                    
                                                case Type.Tag:
                                                    
                                                    matchedObject = results[0] as! Tag
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                                    
                                                case Type.None:
                                                    break
                                                    
                                                default:
                                                    matchedObject = results[0] as! Weapon
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.collection = matchedObject.valueForKey("collection") as? String
                                                    listingItem.weaponType = determineWeapon(matchedObject.valueForKey("weaponType") as! String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.desc = matchedObject.valueForKey("desc") as? String
                                                    listingItem.caseName = matchedObject.valueForKey("caseName") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f") + "2x")
                                            }
                                            
                                            searchResults.append(listingItem)
                                            
                                        } else {
                                            dump(listingItem)
                                            print("No match for...")
                                        }
                                    }
                                }   
                            }
                        
                            if let delegate = self.delegate {
                                delegate.returnResultsForSearch(searchResults)
                            }
                        }
                    
                    } else {
                        print("API returned NULL")
                    }
                }
        })

    }
    
    func getResultForItem(item: MTItem!) {
       
        dispatch_async(dispatch_get_main_queue()) {
        
            if let itemURL = item.itemURL {
                let request = NSURLRequest(URL: itemURL)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                    
                    if let htmlString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                       if htmlString.containsString("var line1=") {
                           let itemPricingData = htmlString.componentsSeparatedByString("var line1=")[1].componentsSeparatedByString("g_timePriceHistoryEarliest = new Date();")[0].stringByReplacingOccurrencesOfString("]];", withString: "]]")

                            let jsonString = JSON(data: itemPricingData.dataUsingEncoding(NSUTF8StringEncoding)!)
                            item.priceHistory = jsonString.array

                            if let delegate = self.delegate {
                                delegate.returnResultForItem!(item)
                            }
                        }
                    }
                }
            }
        }
    }
}
