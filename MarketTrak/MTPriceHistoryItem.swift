//
//  MTPriceHistoryItem.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 6/19/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTPriceHistoryItem: NSObject {
    
    var date: NSDate!
    var price: MTCurrencyItem!
    var quantitySold: Int!
    
    override init() {
        super.init()
    }
}
