//
//  Item.swift
//  
//
//  Created by Jonathon Toon on 12/26/15.
//
//

import Foundation
import CoreData


class Item: NSManagedObject {
    @NSManaged var collection: String?
    @NSManaged var quality: String?
    @NSManaged var searchURL: String?
    @NSManaged var weapon: String?
    @NSManaged var name: String?
    @NSManaged var hasSouvenir: NSNumber?
    @NSManaged var hasStatTrak: NSNumber?
    @NSManaged var type: String?

}
