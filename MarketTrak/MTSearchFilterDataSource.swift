//
//  MTSearchFilterDataSource.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 12/6/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import CoreData

extension Array {
    
    mutating func removeObject<T: Equatable>(object: T) -> Bool {
        var index: Int?
        for (idx, objectToCompare) in self.enumerate() {
            
            if let toCompare = objectToCompare as? T {
                if toCompare == object {
                    index = idx
                    break
                }
            }
        }
        
        if(index != nil) {
            self.removeAtIndex(index!)
            return true
        } else {
            return false
        }
    }
    
    func containsObject(object: Any) -> Bool
    {
        if let anObject: AnyObject = object as? AnyObject
        {
            for obj in self
            {
                if let anObj: AnyObject = obj as? AnyObject
                {
                    if anObj === anObject { return true }
                }
            }
        }
        return false
    }
}

class MTSearchFilterDataSource {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var entityDescription: NSEntityDescription!
    
    let filterObjects: [MTFilter]! = []
    var sortedFilterObjects: [MTFilter]!
    
    let objectArray = [
        "Tournament",
        "Weapon",
        "Quality",
        "Sticker Category",
        "Sticker Collection",
        "Team",
        "Professional Player",
        "Exterior",
        "Type",
        "Collection",
        "category"
    ]
    
    init() {
        entityDescription = NSEntityDescription.entityForName("Filter", inManagedObjectContext: managedObjectContext)
        
        for object in objectArray {
        
            var objects: AnyObject?
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = entityDescription
            fetchRequest.predicate = NSPredicate(format: "name ==[c] %@", object as String)
            
            do {
                objects = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            } catch {
                print("Failed")
            }
            
            if let results = objects {
                
                if results.count > 0 {
                    
                    let filterResult = results[0] as! Filter
                    
                    let filter = MTFilter()
                        filter.name = filterResult.name
                        filter.category = filterResult.category
                        filter.isExpanded = false
                    
                    for var i = 0; i < filterResult.options!.count; i++ {
                        
                        let filterOption = MTFilterOption()
                            filterOption.name = filterResult.options![i]["name"] as! String
                            filterOption.tag = filterResult.options![i]["tag"] as! String
                            filterOption.isApplied = false

                        if filterOption.name != "Any" && filterOption.name != "Not Painted" && filterOption.name != "Normal" {
                            filter.options!.append(filterOption)
                        }
                    }
       
                    filterObjects.append(filter)
                }
            }

        }
        
        sortedFilterObjects = filterObjects
    }

    func sortFiltersBySearchText(searchText: String!) {
        
        if searchText != "" {
        
            var sorted: [MTFilter]! = []
            for filter in filterObjects {
            
                let f: MTFilter = filter
                for option in f.options! {
                    if !option.name.lowercaseString.containsString(searchText.lowercaseString) {
                        f.options!.removeObject(option)
                    }
                }
                sorted.append(f)
            }
            
            sortedFilterObjects = sorted
            
        } else {
           
            sortedFilterObjects = filterObjects
        
        }
    }
    
    func setFilterExpanded(section: Int!, expanded: Bool!) {
        sortedFilterObjects[section].isExpanded = expanded
    }
    
    func filterIsExpanded(section: Int!) -> Bool {
        return sortedFilterObjects[section].isExpanded
    }
    
    func filterOptionForSection(section: Int!, row: Int!) -> MTFilterOption {
        return sortedFilterObjects[section].options![row]
    }
    
    func setFilterOptionApplied(section: Int!, row: Int!, applied: Bool!) {
        (sortedFilterObjects[section].options![row] as MTFilterOption).isApplied = applied
    }
    
    func filterOptionIsApplied(section: Int!, row: Int!) -> Bool {
        
        let option = (sortedFilterObjects[section].options![row] as MTFilterOption)
        return option.isApplied
    }
    
    func availableOptionsForFilter(section: Int!) -> Int {
        
        var availableOptions: Int = 0
        
        for option in sortedFilterObjects[section].options! {
            if !option.isApplied {
                availableOptions++
            }
        }
        
        return availableOptions
    }
}
