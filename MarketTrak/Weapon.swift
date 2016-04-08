//
//  Weapon.swift
//  
//
//  Created by Jonathon Toon on 2/8/16.
//
//

import Foundation
import CoreData


class Weapon: NSManagedObject {

    @NSManaged var caseName: String?
    @NSManaged var collection: String?
    @NSManaged var desc: String?
    @NSManaged var hasSouvenir: NSNumber?
    @NSManaged var hasStatTrak: NSNumber?
    @NSManaged var image: String?
    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var type: String?
    @NSManaged var weaponType: String?

}
