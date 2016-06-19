//
//  MTItem.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/2/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTItem: NSObject {
    
    var name                : String!
    var type                : Type!
    var quality             : Quality?
    var desc                : String?
    var imageURL            : NSURL!
    var itemURL             : NSURL!
    
    // Weapons
    var weaponType          : WeaponType?
    var exterior            : Exterior?
    
    // Weapons, MusicKit
    var category            : Category?
    
    // Container
    var collection          : String?
    var containerSeries     : NSNumber?
    var caseName            : String?
    var stickerCollection   : String?
    var stickerCategory     : String?
    var tournament          : String?
    var items               : JSON?
    
    // Music Kit
    var artistName          : String?
    
    var quantity            : Int?
    var currentPrice        : MTCurrency?
    var priceHistory        : [MTPriceHistory]?
}
