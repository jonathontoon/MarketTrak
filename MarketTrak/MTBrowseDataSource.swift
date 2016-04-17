//
//  MTBrowseDataSource.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 4/17/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTBrowseDataSource: NSObject {
    
    let filterJson: JSON
    
    init(category: String?) {
        
        let path = NSBundle.mainBundle().pathForResource("MarketTrak", ofType: "json")
        let jsonData = NSData(contentsOfFile:path!)
        
        if let cat = category {
            let json = JSON(data: jsonData!)
            filterJson = json[0][cat]
        } else {
            filterJson = JSON(data: jsonData!)[0]
        }
        
        super.init()
    }

}