//
//  Key.swift
//  
//
//  Created by Jonathon Toon on 12/26/15.
//
//

import Foundation
import CoreData


class Key: NSManagedObject {

    @NSManaged var objectId: String?
    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var collection: String?
    @NSManaged var type: String?
    @NSManaged var desc: String?
}
