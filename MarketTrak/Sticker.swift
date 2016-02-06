//
//  Sticker.swift
//  
//
//  Created by Jonathon Toon on 2/6/16.
//
//

import Foundation
import CoreData


class Sticker: NSManagedObject {

    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var stickerCollection: String?
    @NSManaged var tournament: String?
    @NSManaged var type: String?
    @NSManaged var desc: String?
    @NSManaged var image: String?

}
