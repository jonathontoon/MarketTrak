//
//  MTItem.swift
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

class MTItem {

    var name                : String!
    var description         : String!
    var image               : NSURL!
    var attachedStickers    : Sticker?
    
    var collection          : Collection?
    var weapon              : Weapon?
    var exterior            : Exterior?
    var category            : Category?
    var quality             : Quality?
    var stickerCollection   : StickerCollection?
    var stickerCategory     : StickerCategory?
    var tournament          : Tournament?
    var type                : Type!
    
}
