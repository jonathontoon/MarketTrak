//
//  MTSearchQuery.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/3/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearch {

    var query               : String!
//    var collection          : [String]!
//    var professionalPlayer  : [String]!
//    var team                : [String]!
//    var weapon              : [Weapon]!
//    var exterior            : [Exterior]!
//    var category            : [Category]!
//    var quality             : [Quality]!
//    var stickerCollection   : [String]!
//    var stickerCategory     : [String]!
//    var tournament          : [String]!
//    var type                : [Type]!
    var start               : Int!
    var count               : Int!
    
    init(
        query: String = "",
//        collection: [String] = [],
//        professionalPlayer: [String] = [],
//        team: [String] = [],
//        weapon: [Weapon] = [],
//        exterior: [Exterior] = [],
//        category: [Category] = [],
//        quality: [Quality] = [],
//        stickerCollection: [String] = [],
//        stickerCategory: [String] = [],
//        tournament: [String] = [],
//        type: [Type] = [],
        start: Int = 0,
        count: Int = 10
    ) {
        self.query = query
//        self.collection = collection
//        self.professionalPlayer = professionalPlayer
//        self.team = team
//        self.weapon = weapon
//        self.exterior = exterior
//        self.category = category
//        self.quality = quality
//        self.stickerCollection = stickerCollection
//        self.stickerCategory = stickerCategory
//        self.tournament = tournament
//        self.type = type
        self.start = start
        self.count = count
    }
}
