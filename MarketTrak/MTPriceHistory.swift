//
//  MTPriceHistory.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 6/19/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTPriceHistory: NSObject {
    
    var date: NSDate!
    var price: MTCurrency!
    var quantitySold: Int!
    
    override init() {
        super.init()
    }
}
