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
    var itemURL             : NSURL!
    
    var type                : Type!
    var weapon              : Weapon?
    
    var category            : Category?
    var exterior            : Exterior?
    var quality             : Quality?
    
    var collection          : String?
    var stickerCollection   : String?
    var tournament          : String?

    var usage               : String?
    
    var artistName          : String?
    
    var quantity            : Int?
    var price               : String?
    var seller              : NSURL?
    
}
