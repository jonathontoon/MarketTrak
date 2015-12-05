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
    var collection          : [Collection]!
    var professionalPlayer  : [ProfessionalPlayer]!
    var team                : [Team]!
    var weapon              : [Weapon]!
    var exterior            : [Exterior]!
    var category            : [Category]!
    var quality             : [Quality]!
    var stickerCollection   : [StickerCollection]!
    var stickerCategory     : [StickerCategory]!
    var tournament          : [Tournament]!
    var type                : [Type]!
    var start               : Int!
    var count               : Int!
    
    init(
        query: String = "",
        collection: [Collection] = [.None],
        professionalPlayer: [ProfessionalPlayer] = [.None],
        team: [Team] = [.None],
        weapon: [Weapon] = [.None],
        exterior: [Exterior] = [.None],
        category: [Category] = [.None],
        quality: [Quality] = [.None],
        stickerCollection: [StickerCollection] = [.None],
        stickerCategory: [StickerCategory] = [.None],
        tournament: [Tournament] = [.None],
        type: [Type] = [.None],
        start: Int = 0,
        count: Int = 10
    ) {
        self.query = query
        self.collection = collection
        self.professionalPlayer = professionalPlayer
        self.team = team
        self.weapon = weapon
        self.exterior = exterior
        self.category = category
        self.quality = quality
        self.stickerCollection = stickerCollection
        self.stickerCategory = stickerCategory
        self.tournament = tournament
        self.type = type
        self.start = start
        self.count = count
    }
}
