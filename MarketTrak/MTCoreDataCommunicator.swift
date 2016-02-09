//
//  MTCoreDataCommunicator.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/3/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class MTCoreDataCommunicator: NSObject {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let marketItemClasses = [
        "Container",
        "Sticker",
        "Tag",
        "Gift",
        "MusicKit",
        "Weapon",
        "Tool",
        "Key",
        "Pass",
        "Filter"
    ]

    override init() {
        super.init()
        
        setupCoreData()
        
        //dump(queryCoreDataForKeyword("dragon"))
    }

    func setupCoreData() {
        for itemClass in marketItemClasses {
            
            if let path = NSBundle.mainBundle().pathForResource(itemClass, ofType: "json") {
                let data: NSData!
                
                do {
                    data = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
                } catch {
                    data = nil
                }
                
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                let versionNumber: Int? = NSUserDefaults.standardUserDefaults().objectForKey(itemClass+"Version") as? Int
                
                if versionNumber == nil || json["version"].intValue > versionNumber {                    
                    print("run")
                    
                    for result in json["results"] {
                        saveJSONObjectToCoreData(itemClass, object: (result.1 as JSON).dictionaryObject!)
                    }
                    
                    NSUserDefaults.standardUserDefaults().setObject(json["version"].intValue, forKey: itemClass+"Version")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
            }
        }
    }
    
//    private func getJSONFromURL(url urlString: String!, withCompletion:(data: NSData?, response: NSURLResponse?, error: NSError?) -> ()) {
//        
//        urlRequest.URL = NSURL(string: urlString)
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest, completionHandler: withCompletion)
//            task.resume()
//    }
    
//    func checkDatabaseVersion() {
//        
//        getJSONFromURL(url: urlConfigString,
//            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
//        
//            if error == nil {
//                
//                if let dataFromJSON = data {
//                    
//                    let json = JSON(data: dataFromJSON)
//                    let defaults = NSUserDefaults.standardUserDefaults()
//                    
//                    if json["params"]["databaseVersion"].intValue != defaults.valueForKey("databaseVersion") as? Int {
//                        
//                        print("different")  
//                        
//                        defaults.setInteger(json["params"]["databaseVersion"].intValue, forKey: "databaseVersion")
//                        
//                        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//
//                        let objectArray = [
//                            "Filter",
//                            "Key",
//                            "Gift",
//                            "Item",
//                            "MusicKit",
//                            "Pass",
//                            "Tool",
//                            "Container",
//                            "Sticker",
//                            "Tag"
//                        ]
//
//                        for object in objectArray {
//                            self.syncParseData(object)
//                        }
//                        
//                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//                    }
//                }
//            }
//        })
//        
//    }
    
//    private func syncParseData(className: String!) {
//        
//        getJSONFromURL(url: urlClassesString + className + "?limit=1000",
//            withCompletion: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
//                
//            if error == nil {
//    
//                if let dataFromJSON = data {
//                    
//                    let json = JSON(data: dataFromJSON)
//                    for result in json["results"] {
//                        self.saveJSONObjectToCoreData(className, object: (result.1 as JSON).dictionaryObject!)
//                    }
//                    
//                }
//            }
//        })
//
//    }
    
    private func saveJSONObjectToCoreData(className: String!, object: [String: AnyObject?]!) {
        
        let entityDescription = NSEntityDescription.entityForName(className, inManagedObjectContext: managedObjectContext)
        let fetch = NSFetchRequest(entityName: className)
        
        var predicate: NSPredicate?
        var entity: NSManagedObject?
        
        switch className {
            
            case "Key":
                
                entity = Key(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Key).name = object["name"] as? String
                (entity as! Key).quality = object["quality"] as? String
                (entity as! Key).collection = object["collection"] as? String
                (entity as! Key).type = object["type"] as? String
                (entity as! Key).desc = object["desc"] as? String
                (entity as! Key).image = object["image"] as? String
            
                predicate = NSPredicate(format: "name = %@ AND type = %@", argumentArray: [(entity as! Key).name!, (entity as! Key).type!])
                
            case "Gift":
                
                entity = Gift(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Gift).name = object["name"] as? String
                (entity as! Gift).quality = object["quality"] as? String
                (entity as! Gift).type = object["type"] as? String
                (entity as! Gift).desc = object["desc"] as? String
                (entity as! Gift).image = object["image"] as? String
                (entity as! Gift).containerSeries = object["containerSeries"] as? NSNumber
            
                predicate = NSPredicate(format: "name = %@ AND type = %@", argumentArray: [(entity as! Gift).name!, (entity as! Gift).type!])
            
            case "Weapon":
                
                entity = Weapon(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Weapon).name = object["name"] as? String
                (entity as! Weapon).quality = object["quality"] as? String
                (entity as! Weapon).collection = object["collection"] as? String
                (entity as! Weapon).hasStatTrak = object["hasStatTrak"] as? NSNumber
                (entity as! Weapon).hasSouvenir = object["hasSouvenir"] as? NSNumber
                (entity as! Weapon).weapon = object["weapon"] as? String
                (entity as! Weapon).type = object["type"] as? String
                (entity as! Weapon).desc = object["desc"] as? String
                (entity as! Weapon).image = object["image"] as? String
                (entity as! Weapon).caseName = object["case"] as? String
                
                predicate = NSPredicate(format: "name = %@ AND weapon = %@", argumentArray: [(entity as! Weapon).name!, (entity as! Weapon).weapon!])
                
            case "MusicKit":
                
                entity = MusicKit(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! MusicKit).name = object["name"] as? String
                (entity as! MusicKit).quality = object["quality"] as? String
                (entity as! MusicKit).hasStatTrak = object["hasStatTrak"] as? NSNumber
                (entity as! MusicKit).artistName = object["artistName"] as? String
                (entity as! MusicKit).type = object["type"] as? String
                (entity as! MusicKit).desc = object["desc"] as? String
                (entity as! MusicKit).image = object["image"] as? String
            
                predicate = NSPredicate(format: "name = %@ AND type = %@", argumentArray: [(entity as! MusicKit).name!, (entity as! MusicKit).type!])
            
            case "Pass":
                
                entity = Pass(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Pass).name = object["name"] as? String
                (entity as! Pass).quality = object["quality"] as? String
                (entity as! Pass).collection = object["collection"] as? String
                (entity as! Pass).desc = object["desc"] as? String
                (entity as! Pass).type = object["type"] as? String
                (entity as! Pass).image = object["image"] as? String
                
                predicate = NSPredicate(format: "name = %@ AND type = %@", argumentArray: [(entity as! Pass).name!, (entity as! Pass).type!])
                
            case "Tool":
                
                entity = Tool(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Tool).name = object["name"] as? String
                (entity as! Tool).quality = object["quality"] as? String
                (entity as! Tool).desc = object["desc"] as? String
                (entity as! Tool).type = object["type"] as? String
                (entity as! Tool).image = object["image"] as? String
                
                predicate = NSPredicate(format: "name = %@ AND type = %@", argumentArray: [(entity as! Tool).name!, (entity as! Tool).type!])
                
            case "Container":
                
                entity = Container(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Container).name = object["name"] as? String
                (entity as! Container).quality = object["quality"] as? String
                (entity as! Container).tournament = object["tournament"] as? String
                (entity as! Container).collection = object["collection"] as? String
                (entity as! Container).items = object["items"] as? NSArray
                (entity as! Container).type = object["type"] as? String
                (entity as! Container).desc = object["desc"] as? String
                (entity as! Container).image = object["image"] as? String
                (entity as! Container).containerSeries = object["containerSeries"] as? NSNumber
            
                predicate = NSPredicate(format: "name = %@ AND type = %@", argumentArray: [(entity as! Container).name!, (entity as! Container).type!])
            
            case "Sticker":
                
                entity = Sticker(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Sticker).name = object["name"] as? String
                (entity as! Sticker).quality = object["quality"] as? String
                (entity as! Sticker).tournament = object["tournament"] as? String
                (entity as! Sticker).stickerCollection = object["stickerCollection"] as? String
                (entity as! Sticker).type = object["type"] as? String
                (entity as! Sticker).desc = object["desc"] as? String
                (entity as! Sticker).image = object["desc"] as? String
            
                predicate = NSPredicate(format: "name = %@ AND type = %@", argumentArray: [(entity as! Sticker).name!, (entity as! Sticker).type!])
                
            case "Tag":
                
                entity = Tag(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Tag).name = object["name"] as? String
                (entity as! Tag).quality = object["quality"] as? String
                (entity as! Tag).desc = object["desc"] as? String
                (entity as! Tag).type = object["type"] as? String
                (entity as! Tag).image = object["image"] as? String
            
                predicate = NSPredicate(format: "name = %@ AND type = %@", argumentArray: [(entity as! Tag).name!, (entity as! Tag).type!])
                
            case "Filter":
                
                entity = Filter(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                (entity as! Filter).name = object["name"] as? String
                (entity as! Filter).category = object["category"] as? String
                (entity as! Filter).options = object["options"] as? NSArray
            
                predicate = NSPredicate(format: "name = %@ AND options = %@", argumentArray: [(entity as! Filter).name!, (entity as! Filter).options!])
                
            default:
                print("##########")
                break
        }
        
        fetch.predicate = predicate
        
        var fetchedObjects: [AnyObject]!
        do {
            fetchedObjects = try managedObjectContext.executeFetchRequest(fetch)
        } catch {
            fetchedObjects = nil
        }
        
        if fetchedObjects.count == 1 {
            do {
                try managedObjectContext.save()
            } catch {
                print("Failed")
            }
            
        } else {
            managedObjectContext.undo()
        }
        
    }
    
    func fetchCoreDataObjectFromQuery(keyword: String!) -> [AnyObject] {
        
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@ OR desc CONTAINS[c] %@", argumentArray: [keyword, keyword])
        var fetchedObjects: [AnyObject] = []
        
        for itemClass in marketItemClasses {
        
            if itemClass != "Filter" {
                let fetch = NSFetchRequest(entityName: itemClass)
                    fetch.predicate = predicate
                do {
                    fetchedObjects += try managedObjectContext.executeFetchRequest(fetch)
                } catch {
                    print("No objects found")
                }
            }
        }
        
        return fetchedObjects
    }
}
