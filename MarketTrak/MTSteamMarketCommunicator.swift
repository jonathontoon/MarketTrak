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
    
    optional func searchResultsReturnedSuccessfully(searchResults: [MTListingItem]!)
    optional func largeItemResultReturnedSuccessfully(largeItemResult: MTLargeItem!)
    
}

class MTSteamMarketCommunicator: NSObject {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let coreDataCommunicator = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataCommunicator
    
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

        var searchResults: [MTListingItem] = []
        let searchURL = search.constructSearchURL()
        
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
                                
                                if let innerDoc = Kanna.HTML(html: node.innerHTML!, encoding: NSUTF8StringEncoding) {
              
                                    let listingItem = MTListingItem()
                                    
                                    // Item URL
                                    if let itemURL = node["href"] {
                                        listingItem.itemURL = NSURL(string: itemURL)
                                    }
                                    
                                    // Price
                                    listingItem.price = String(unescapeSpecialCharacters: node.css("div.market_listing_their_price span.market_table_value span.normal_price").text)
                                    
                                    // Quantity
                                    listingItem.quantity = String(unescapeSpecialCharacters: node.css("span.market_listing_num_listings_qty").text) + " Available"
                                    
                                    //Full Name
                                    listingItem.fullName = node.at_css("span.market_listing_item_name")!.text!
                                    
                                    // Weapon
                                    listingItem.weaponType = determineWeapon(listingItem.fullName)
                                    
                                    // Item Name
                                    listingItem.name = determineItemName(listingItem.fullName)
                            
                                    // Type
                                    listingItem.type = determineType(listingItem.fullName)
                                    
                                    // Category
                                    listingItem.category = determineCategory(listingItem.fullName)
                                    
                                    // Exterior
                                    listingItem.exterior = determineExterior(listingItem.fullName)
                
                                    
                                    let entityDescription: NSEntityDescription!
                                    let objects: [AnyObject]!
                                    var predicate: NSPredicate! = NSPredicate(format: "name ==[cd] %@ AND type ==[cd] %@", listingItem.name, listingItem.type.stringDescription())
                                    
                                    if listingItem.weaponType != nil && listingItem.weaponType != WeaponType.None {
                                        predicate = NSPredicate(format: "name ==[cd] %@ AND type ==[cd] %@ AND weapon ==[cd] %@", listingItem.name, listingItem.type.stringDescription(), listingItem.weaponType!.stringDescription())
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
                                        
                                        case Type.None: 
                                        
                                            entityDescription = nil
                                            break
                                    
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
                                                    listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f"))
                                                
                                                case Type.Gift:
                                                    
                                                    matchedObject = results[0] as! Gift
                                                    listingItem.name = matchedObject.valueForKey("name") as! String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                                    listingItem.containerSeries = matchedObject.valueForKey("containerSeries") as? NSNumber
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f"))
                                                
                                                case Type.MusicKit:
                                                    
                                                    matchedObject = results[0] as! MusicKit
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.artistName = matchedObject.valueForKey("artistName") as? String
                                                    listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f"))
                                                    
                                                case Type.Pass:
                                                    
                                                    matchedObject = results[0] as! Pass
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.collection = matchedObject.valueForKey("collection") as? String
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f"))
                                                
                                                case Type.Tool:
                                                    
                                                    matchedObject = results[0] as! Tool
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f"))
                                                    
                                                case Type.Container:
                                                    
                                                    matchedObject = results[0] as! Container
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.tournament = matchedObject.valueForKey("tournament") as? String
                                                    listingItem.collection = matchedObject.valueForKey("collection") as? String
                                                    listingItem.items = matchedObject.valueForKey("items") as? NSArray
                                                    listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                                    listingItem.containerSeries = matchedObject.valueForKey("containerSeries") as? NSNumber
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f"))
                                            
                                                case Type.Sticker:
                                                    
                                                    matchedObject = results[0] as! Sticker
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.tournament = matchedObject.valueForKey("tournament") as? String
                                                    listingItem.stickerCollection = matchedObject.valueForKey("stickerCollection") as? String
                                                    listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f"))
                                                 
                                                case Type.Tag:
                                                    
                                                    matchedObject = results[0] as! Tag
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f"))
                                                
                                                case Type.None:
                                                    break
                                                
                                                default:
                                                    matchedObject = results[0] as! Weapon
                                                    listingItem.name = matchedObject.valueForKey("name") as? String
                                                    listingItem.quality = determineQuality(matchedObject.valueForKey("quality") as? String)
                                                    listingItem.collection = matchedObject.valueForKey("collection") as? String
                                                    listingItem.weaponType = determineWeapon(matchedObject.valueForKey("weapon") as! String)
                                                    listingItem.type = determineType(matchedObject.valueForKey("type") as! String)
                                                    listingItem.itemDescription = matchedObject.valueForKey("desc") as? String
                                                    listingItem.caseName = matchedObject.valueForKey("caseName") as? String
                                                    listingItem.imageURL = NSURL(string: (matchedObject.valueForKey("image") as? String)!.stringByReplacingOccurrencesOfString("360f", withString: "512f"))
                                            }

                                        } else {
                                            print("No match for...")
                                            dump(listingItem)
                                            dump(results)
                                            
                                        }
                                    }
                                    
                                        searchResults.append(listingItem)
                                        
                                    }

                                }

                            }
                            
                            dump(searchResults)
                            
                            if let delegate = self.delegate {
                                delegate.searchResultsReturnedSuccessfully!(searchResults)
                            }
                        }
                    
                    } else {
                    
                        print("API returned NULL")
                        
                    }
                }
        })

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
            largeItem.itemName = searchResultItem.name
        
            //Price
            largeItem.price = searchResultItem.price
        
            //Image
            largeItem.imageURL = NSURL(string: searchResultItem.imageURL.absoluteString.stringByReplacingOccurrencesOfString("32f", withString: "160f"))
        
            //Exterior
            largeItem.exterior = searchResultItem.exterior
            
            //Weapon
            largeItem.weaponType = searchResultItem.weaponType
            
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
                                    if largeItem.weaponType != WeaponType.None {
                                        
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
            })
        
    }
}
