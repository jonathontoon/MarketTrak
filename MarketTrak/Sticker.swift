//
//  Sticker.swift
//  
//
//  Created by Jonathon Toon on 12/26/15.
//
//

import Foundation
import CoreData


class Sticker: NSManagedObject {

    @NSManaged var objectId: String?
    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var stickerCollection: String?
    @NSManaged var tournament: String?
    @NSManaged var type: String?

}
