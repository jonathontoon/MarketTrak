//
//  MTListingItem.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/2/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTListingItem: NSObject {
    
    var name                : String!
    var fullName            : String!
    
    var imageURL            : NSURL!
    var itemURL             : NSURL!
    
    var type                : Type!
    var weaponType          : WeaponType?
    
    var category            : Category?
    var exterior            : Exterior?
    var quality             : Quality?
    
    var collection          : String?
    var containerSeries     : NSNumber?
    var caseName            : String?
    var stickerCollection   : String?
    var stickerCategory     : String?
    var tournament          : String?

    var desc                : String?
    
    var items               : NSArray?
    
    var artistName          : String?
    
    var quantity            : String?
    var initialPrice        : String?
    var currentPrice        : String?
    var seller              : NSURL?
    
}
