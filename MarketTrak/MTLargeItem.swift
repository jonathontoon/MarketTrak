//
//  MTLargeItem.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/2/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

//struct Sticker {
//    var stickerImages       : [UIImage]!
//    var stickerDescription  : String!
//}

class MTDetailItem: NSObject {

    var fullName            : String!
    var itemName            : String!
    var imageURL            : NSURL!
    
    var desc                : String!
    
    var initialPrice        : String?
    
    var collection          : String?
    var weaponType          : WeaponType?
    var exterior            : Exterior?
    var category            : Category?
    var quality             : Quality?
    var type                : Type!
    
    var stickerCollection   : String?
    var stickerCategory     : String?
    
    var tournament          : String?
}
