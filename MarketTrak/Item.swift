//
//  Item.swift
//  
//
//  Created by Jonathon Toon on 2/6/16.
//
//

import Foundation
import CoreData


class Item: NSManagedObject {

    @NSManaged var collection: String?
    @NSManaged var hasSouvenir: NSNumber?
    @NSManaged var hasStatTrak: NSNumber?
    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var type: String?
    @NSManaged var weapon: String?
    @NSManaged var desc: String?
    @NSManaged var image: String?
    @NSManaged var caseName: String?

}
