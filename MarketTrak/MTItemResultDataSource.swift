//
//  MTItemResultDataSource.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/8/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit


class MTItemResultDataSource: NSObject {
    
    var popularResults: [MTItem]!
    var nameResults: [MTItem]!
    var quantityResults: [MTItem]!
    var priceResults: [MTItem]!
    
    var results: [MTItem]!
    
    init(items: [MTItem]) {
        super.init()
        
        popularResults = items
    }
}