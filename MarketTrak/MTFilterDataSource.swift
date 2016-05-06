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
    
    let filters: JSON!
    var currentFilters: JSON!

    override init() {
        
        let path = NSBundle.mainBundle().pathForResource("MarketFilters", ofType: "json")
        filters = JSON(data: NSData(contentsOfFile:path!)!)
        currentFilters = filters
        
        for i in 0..<filters.count {
            currentFilters[i]["options"] = []
        }
    }
}
