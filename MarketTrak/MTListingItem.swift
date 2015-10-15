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
    var skinName            : String!
    var imageURL            : NSURL!
    var textColor           : String?
    
    var quantity            : Int?
    var price               : String?
    var seller              : NSURL?
    
    var weapon              : Weapon?
    var exterior            : Exterior?
    var category            : Category?
    var type                : Type!
    
}
