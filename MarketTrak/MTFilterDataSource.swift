//
//  MTSearchFilterDataSource.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 12/6/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTFilterDataSource: NSObject {
    
    var filters: [MTFilterCategory]! = []
    var displayedFilters: [MTFilterCategory]! = []
    var selectedCategory: Int?
    var selectedFilters: [NSIndexPath]! = []
    
    
    override init() {
        
        let path = NSBundle.mainBundle().pathForResource("MarketFilters", ofType: "json")
        let json = JSON(data: NSData(contentsOfFile:path!)!)
        
        for i in 0..<json.count {
            
            let f = MTFilterCategory()
                f.name = json[i]["name"].stringValue
                f.category = json[i]["category"].stringValue
            
            displayedFilters.append(f)
        }
        
        for k in 0..<json.count {
            
            let fc = MTFilterCategory()
                fc.name = json[k]["name"].stringValue
                fc.category = json[k]["category"].stringValue
            
            if let options = json[k]["options"].array {
                
                for j in 0..<options.count {
                    
                    let f = MTFilter()
                        f.name = options[j]["name"].stringValue
                        f.tag = options[j]["tag"].stringValue
                    
                    fc.options?.append(f)
                }
                
            }
            
            filters.append(fc)
        }
    }
    
    func addOptionsToFilterCategory(category: Int) {
        print("add section" + category.description)
        if let options = filters[category].options {
            displayedFilters[category].options = options
            selectedCategory = category
        }
    }
    
    func removeOptionsFromFilterCategory(category: Int) {
        print("remove section" + category.description)
        displayedFilters[category].options = []
        selectedCategory = nil
    }
}
