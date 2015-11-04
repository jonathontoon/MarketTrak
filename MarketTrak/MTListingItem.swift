//
//  MTListingItem.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/2/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTListingItem: NSObject {
    
    var fullName            : String!
    var itemName            : String!
    var imageURL            : NSURL!
    
    var quantity            : Int?
    var price               : String?
    var seller              : NSURL?
    
    var type                : Type!
    var weapon              : Weapon?
    var collection          : Collection?
    
    var containedItems      : NSArray?
    
    var stickerCollection   : StickerCollection?
    var tournament          : Tournament?
    
    var category            : Category?
    var exterior            : Exterior?
    var quality             : Quality?
    
    var usage               : String?
    
    var artist              : String?
}
