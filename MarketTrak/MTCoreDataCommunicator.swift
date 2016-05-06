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
        "Pass"
    ]

    class func setupCoreData(completion: (completed: Bool) -> Void) {
    
        let fileManager = NSFileManager.defaultManager()
        let databaseVersionNumber = 1
        
        let documentsDirectory = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask)
        
        let versionNumber: Int? = NSUserDefaults.standardUserDefaults().objectForKey("MarketTrakVersion") as? Int

        if versionNumber == nil || versionNumber < databaseVersionNumber {
        
            if let prepopulatedDatabasePath = NSBundle.mainBundle().URLForResource("MarketTrak", withExtension: "sqlite") {
                if fileManager.fileExistsAtPath(prepopulatedDatabasePath.path!) {
                    
                    let url = documentsDirectory[0].URLByAppendingPathComponent("MarketTrak.sqlite")
                    
                    if fileManager.fileExistsAtPath(url.path!) {
                        do {
                            try fileManager.removeItemAtPath(url.path!)
                            print("Existing file deleted.")
                        } catch {
                            print("Failed to delete existing file:\n\((error as NSError).description)")
                        }
                    }
                    
                    do {
                        try fileManager.copyItemAtURL(prepopulatedDatabasePath, toURL: url)
                        NSUserDefaults.standardUserDefaults().setObject(databaseVersionNumber, forKey: "MarketTrakVersion")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        completion(completed: true)
                    } catch {
                        print("File copy failed!")
                        completion(completed: false)
                    }
                    
                }
            }
        
        } else {
            completion(completed: true)
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
                    dump(fetch)
                } catch {
                    print("No objects found")
                }
            }
        }
        
        return fetchedObjects
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
