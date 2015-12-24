//
//  MTLargeItem.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/2/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

struct Sticker {
    var stickerImages       : [UIImage]!
    var stickerDescription  : String!
}

class MTLargeItem: NSObject {

    var fullName            : String!
    var itemName            : String!
    var imageURL            : NSURL!
    
    var itemDescription     : String!
    
    var price               : String?
    
    var collection          : String?
    var weapon              : Weapon?
    var exterior            : Exterior?
    var category            : Category?
    var quality             : Quality?
    var type                : String!
    
    var stickerCollection   : String?
    var stickerCategory     : String?
    
    var tournament          : String?
}
