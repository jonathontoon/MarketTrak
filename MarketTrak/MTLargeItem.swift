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
    var skinName            : String!
    var imageURL            : NSURL!
    var textColor           : String?
    
    var itemDescription     : String!
    
    var collection          : Collection?
    var weapon              : Weapon?
    var exterior            : Exterior?
    var category            : Category?
    var quality             : Quality?
    var type                : Type!
    
    var stickerCollection   : StickerCollection?
    var stickerCategory     : StickerCategory?
    
    var tournament          : Tournament?
}
