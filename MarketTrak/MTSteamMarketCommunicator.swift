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
import Parse
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
    
    optional func searchResultsReturnedSuccessfully(searchResults: [MTListingItem]!)
    optional func largeItemResultReturnedSuccessfully(largeItemResult: MTLargeItem!)
    
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
    
//    func combineStringsForFilters(search: MTSearch) -> String {
//        
//        var combinedURL = ""
//        
//        for i in 0..<search.collection.count {
//            combinedURL += search.collection[i].urlArgument()
//        }
//        
//        for i in 0..<search.professionalPlayer.count {
//            combinedURL += search.professionalPlayer[i].urlArgument()
//        }
//        
//        for i in 0..<search.team.count {
//            combinedURL += search.team[i].urlArgument()
//        }
//        
//        for i in 0..<search.weapon.count {
//            combinedURL += search.weapon[i].urlArgument()
//        }
//        
//        for i in 0..<search.exterior.count {
//            combinedURL += search.exterior[i].urlArgument()
//        }
//        
//        for i in 0..<search.category.count {
//            combinedURL += search.category[i].urlArgument()
//        }
//        
//        for i in 0..<search.quality.count {
//            combinedURL += search.quality[i].urlArgument()
//        }
//        
//        for i in 0..<search.stickerCollection.count {
//            combinedURL += search.stickerCollection[i].urlArgument()
//        }
//        
//        for i in 0..<search.stickerCategory.count {
//            combinedURL += search.stickerCategory[i].urlArgument()
//        }
//        
//        for i in 0..<search.tournament.count {
//            combinedURL += search.tournament[i].urlArgument()
//        }
//        
//        for i in 0..<search.type.count {
//            combinedURL += search.type[i].urlArgument()
//        }
//        
//        return combinedURL
//    }
    
func getResultsForSearch(search: MTSearch) {
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    
    var searchURL = "http://steamcommunity.com/market/search/render?query="
        searchURL += search.query!
        searchURL = searchURL.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        searchURL += "&appid=730"
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
                        
                        let listingNodes = doc.body!.css("a.market_listing_row_link")
                        
                        for node in listingNodes {
                            
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
                                
                                //Item Name
                                listingItem.name = determineItemName(listingItem.fullName)
                                
                                //Category
                                listingItem.category = determineCategory(listingItem.fullName)
   
                                //Type
                                listingItem.type = determineType(listingItem.fullName)
                                
                                var entityDescription: NSEntityDescription!
                                var objects: [AnyObject]!
                                var predicates = [NSPredicate(format: "name ==[c] %@", listingItem.name), NSPredicate(format: "type ==[c] %@", listingItem.type!.stringDescription())]
                                
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
                                        predicates[0] = NSPredicate(format: "name ==[c] %@", listingItem.fullName)
                                    
                                case Type.None: 
                                    
                                        break
                                
                                    default:
                                        
                                        entityDescription = NSEntityDescription.entityForName("Item", inManagedObjectContext: self.managedObjectContext)
                                        predicates.append(NSPredicate(format: "weapon ==[c] %@", listingItem.weapon!.stringDescription()))
                                }
                                
                                    let fetchRequest = NSFetchRequest()
                                        fetchRequest.entity = entityDescription
                                        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
              
                                do {
                                    objects = try self.managedObjectContext.executeFetchRequest(fetchRequest)
                                } catch {
                                    print("Failed")
                                }
                                
                                if let results = objects {

                                    if results.count > 0 {
                                        
                                        var matchedObject: NSManagedObject!
                                        
                                        switch listingItem.type! {
                                            
                                        case Type.Key:
                                            
                                            matchedObject = results[0] as! Key
                                            listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                            listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                            listingItem.collection = matchedObject.valueForKey("collection") as? String
                                            listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                            
                                        case Type.Gift:
                                            
                                            matchedObject = results[0] as! Gift
                                            listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                            listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                            listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                            
                                        case Type.MusicKit:
                                            
                                            matchedObject = results[0] as! MusicKit
                                            listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                            listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                            listingItem.artistName = matchedObject.valueForKey("artistName") as? String
                                            
                                        case Type.Pass:
                                            
                                            matchedObject = results[0] as! Pass
                                            listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                            listingItem.collection = matchedObject.valueForKey("collection") as? String
                                            listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                            listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                            
                                        case Type.Tool:
                                            
                                            matchedObject = results[0] as! Tool
                                            listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                            listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                            listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                            
                                        case Type.Container:
                                            
                                            matchedObject = results[0] as! Container
                                            listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                            listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                            listingItem.tournament = matchedObject.valueForKey("tournament") as? String
                                            listingItem.collection = matchedObject.valueForKey("collection") as? String
                                            listingItem.items = matchedObject.valueForKey("items") as? NSArray
                                            
                                        case Type.Sticker:
                                            
                                            matchedObject = results[0] as! Sticker
                                            listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                            listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                            listingItem.tournament = matchedObject.valueForKey("tournament") as? String
                                            listingItem.stickerCollection = matchedObject.valueForKey("stickerCollection") as? String
                                            
                                        case Type.Tag:
                                            
                                            matchedObject = results[0] as! Tag
                                            listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                            listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                            listingItem.itemDescription = matchedObject.valueForKey("desc") as? String

                                        case Type.None:
                                            
                                            break
                                        
                                        default:
                                            matchedObject = results[0] as! Item
                                            listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                            listingItem.collection = matchedObject.valueForKey("collection") as? String
                                            listingItem.weapon = determineWeapon(matchedObject.valueForKey("weapon") as! String)
                                            listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                        }

                                    } else {
                                        print("No match for...")
                                    }
                                    
                                    searchResults.append(listingItem)
                                    
                                }

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
    
//    func getResultsForItem(searchResultItem: MTListingItem!) {
//        
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//        
//        var itemURL = "http://steamcommunity.com/market/listings/730/"
//            itemURL += searchResultItem.fullName!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
//            itemURL = itemURL.stringByReplacingOccurrencesOfString("(", withString: "%28")
//            itemURL = itemURL.stringByReplacingOccurrencesOfString(")", withString: "%29")
//            itemURL += "/render?start=0&count=2&currency=1&language=english"
//        
//        let largeItem = MTLargeItem()
//        
//            //FullName
//            largeItem.fullName = searchResultItem.fullName
//        
//            //itemName
//            largeItem.itemName = searchResultItem.itemName
//        
//            //Price
//            largeItem.price = searchResultItem.price
//        
//            //Image
//            largeItem.imageURL = NSURL(string: searchResultItem.imageURL.absoluteString.stringByReplacingOccurrencesOfString("32f", withString: "160f"))
//        
//            //Exterior
//            largeItem.exterior = searchResultItem.exterior
//            
//            //Weapon
//            largeItem.weapon = searchResultItem.weapon
//            
//            //Type
//            largeItem.type = searchResultItem.type
//            
//            //Category
//            largeItem.category = searchResultItem.category
//        
//            //Collection
//            largeItem.collection = searchResultItem.collection
//        
//        getJSONFromURL(
//            url: itemURL,
//            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
//                
//                if error == nil {
//                    
//                    if let dataFromJSON = data {
//                        
//                        let json = JSON(data: dataFromJSON)
//                        
//                        if json.description != "null" {
//                        
//                            for itemObject in json["assets"]["730"]["2"] {
//                                
//                                let item = itemObject.1 as JSON
//                                print(item)
//                                
//                                //Quality
//                                largeItem.quality = determineQuality(item["type"].stringValue)
//                                
//                                //ItemDescription
//                                if largeItem.weapon != Weapon.Any {
//                                    
//                                    if largeItem.type == Type.Sticker {
//                                    
//                                        if largeItem.category == Category.Souvenir {
//                                            largeItem.itemDescription = item["descriptions"][item["descriptions"].count-9]["value"].stringValue
//                                            largeItem.itemDescription = largeItem.itemDescription + " " + item["descriptions"][item["descriptions"].count-7]["value"].stringValue
//                                            largeItem.itemDescription = largeItem.itemDescription + " \n " + item["descriptions"][item["descriptions"].count-5]["value"].stringValue
//                                        } else {
//                                            largeItem.itemDescription = item["descriptions"][item["descriptions"].count-5]["value"].stringValue
//                                        }
//                                        
//                                    } else if largeItem.type == Type.Knife {
//                                    
//                                        largeItem.itemDescription = item["descriptions"][item["descriptions"].count-2 ]["value"].stringValue
//                                        
//                                    } else {
//                                        
//                                        largeItem.itemDescription = item["descriptions"][item["descriptions"].count-4]["value"].stringValue
//                                    
//                                    }
//                                }
//                                
//                            }
//                            
//                            if let delegate = self.delegate {
//                                
//                                delegate.largeItemResultReturnedSuccessfully!(largeItem)
//                                
//                            }
//
//                        } else {
//                            
//                            print("API returned NULL")
//                            
//                        }
//                    }
//                    
//                } else {
//                    
//                    print(error)
//                    
//                }
//            }
//        )
//        
//    }
}
