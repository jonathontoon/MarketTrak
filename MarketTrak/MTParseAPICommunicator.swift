//
//  MTParseAPICommunicator.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/3/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class MTParseAPICommunicator: NSObject {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let parseApplicationID = "8w1MePaFXCoG5mnQw636Pt6eQzvwuRXhy948U1dT"
    let parseRestClientKey = "D2nIMTqBZlrgGTSvQeB3KYMKWWu5AYhMFlDwqYnk"
 
    let urlClassesString = "https://api.parse.com/1/classes/"
    let urlConfigString = "https://api.parse.com/1/config"
    var urlRequest: NSMutableURLRequest!
    
    override init() {
    
        urlRequest = NSMutableURLRequest()
        urlRequest.HTTPMethod = "GET"
        urlRequest.addValue(parseApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        urlRequest.addValue(parseRestClientKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

    }

    private func getJSONFromURL(url urlString: String!, withCompletion:(data: NSData?, response: NSURLResponse?, error: NSError?) -> ()) {
        
        urlRequest.URL = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest, completionHandler: withCompletion)
            task.resume()
    }
    
    func checkDatabaseVersion() {
        
        getJSONFromURL(url: urlConfigString,
            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
        
            if error == nil {
                
                if let dataFromJSON = data {
                    
                    let json = JSON(data: dataFromJSON)
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    
                    if json["params"]["databaseVersion"].intValue != defaults.valueForKey("databaseVersion") as? Int {
                        
                        defaults.setInteger(json["params"]["databaseVersion"].intValue, forKey: "databaseVersion")
                        
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

                        let objectArray = [
                            "Key",
                            "Gift",
                            "Item",
                            "MusicKit",
                            "Pass",
                            "Tool",
                            "Container",
                            "Sticker",
                            "Tag"
                        ]

                        for object in objectArray {
                            
                            self.syncParseData(object)
                            
                        }
                        
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        
                    }
                }
            }
        })
        
    }
    
    private func syncParseData(className: String!) {
        
        getJSONFromURL(url: urlClassesString + className + "?limit=1000",
            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
            if error == nil {
    
                if let dataFromJSON = data {
                    
                    let json = JSON(data: dataFromJSON)
                    for result in json["results"] {
                        self.saveJSONObjectToCoreData(className, object: (result.1 as JSON).dictionaryObject!)
                    }
                    
                }
            }
        })

    }
    
    private func saveJSONObjectToCoreData(className: String!, object: [String: AnyObject?]!) {
        let entityDescription = NSEntityDescription.entityForName(className, inManagedObjectContext: managedObjectContext)
        
        var entity: NSManagedObject!
        
        switch className {
            
            case "Key":
                
                entity = Key(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Key).objectId = object["objectId"] as? String
                (entity as! Key).name = object["name"] as? String
                (entity as! Key).quality = object["quality"] as? String
                (entity as! Key).collection = object["collection"] as? String
                //(entity as! Key).type = object["type"] as? String
                (entity as! Key).desc = object["desc"] as? String
                
            case "Gift":
                
                entity = Gift(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Gift).objectId = object["objectId"] as? String
                (entity as! Gift).name = object["name"] as? String
                (entity as! Gift).quality = object["quality"] as? String
                //(entity as! Gift).type = object["type"] as? String
                (entity as! Gift).desc = object["desc"] as? String
                
            case "Item":
                
                entity = Item(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Item).objectId = object["objectId"] as? String
                (entity as! Item).name = object["name"] as? String
                (entity as! Item).quality = object["quality"] as? String
                (entity as! Item).collection = object["collection"] as? String
                (entity as! Item).hasStatTrak = object["hasStatTrak"] as? NSNumber
                (entity as! Item).hasSouvenir = object["hasSouvenir"] as? NSNumber
                (entity as! Item).weapon = object["weapon"] as? String
                //(entity as! Item).type = object["type"] as? String
            
            case "MusicKit":
                
                entity = MusicKit(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! MusicKit).objectId = object["objectId"] as? String
                (entity as! MusicKit).name = object["name"] as? String
                (entity as! MusicKit).quality = object["quality"] as? String
                (entity as! MusicKit).hasStatTrak = object["hasStatTrak"] as? NSNumber
                (entity as! MusicKit).artistName = object["artistName"] as? String
                //(entity as! MusicKit).type = object["type"] as? String
            
            case "Pass":
                
                entity = Pass(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Pass).objectId = object["objectId"] as? String
                (entity as! Pass).name = object["name"] as? String
                (entity as! Pass).quality = object["quality"] as? String
                (entity as! Pass).collection = object["collection"] as? String
                (entity as! Pass).desc = object["desc"] as? String
                //(entity as! Pass).type = object["type"] as? String
            
            case "Tool":
                
                entity = Tool(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Tool).objectId = object["objectId"] as? String
                (entity as! Tool).name = object["name"] as? String
                (entity as! Tool).quality = object["quality"] as? String
                (entity as! Tool).desc = object["desc"] as? String
                //(entity as! Tool).type = object["type"] as? String
            
            case "Container":
                
                entity = Container(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Container).objectId = object["objectId"] as? String
                (entity as! Container).name = object["name"] as? String
                (entity as! Container).quality = object["quality"] as? String
                //(entity as! Container).type = object["type"] as? String
                (entity as! Container).tournament = object["tournament"] as? String
                (entity as! Container).collection = object["collection"] as? String
                (entity as! Container).items = object["items"] as? NSArray
            
            case "Sticker":
                
                entity = Sticker(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Sticker).objectId = object["objectId"] as? String
                (entity as! Sticker).name = object["name"] as? String
                (entity as! Sticker).quality = object["quality"] as? String
                //(entity as! Sticker).type = object["type"] as? String
                (entity as! Sticker).tournament = object["tournament"] as? String
                (entity as! Sticker).stickerCollection = object["stickerCollection"] as? String
            
            case "Tag":
                
                entity = Tag(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Tag).objectId = object["objectId"] as? String
                (entity as! Tag).name = object["name"] as? String
                (entity as! Tag).quality = object["quality"] as? String
                (entity as! Tag).desc = object["desc"] as? String
                //(entity as! Tag).type = object["type"] as? String
            
            default:
                print("##########")
                break
        }
        
        do {
            
            try managedObjectContext.save()
            
        } catch {
            print("Failed")
        }
        
    }
}
