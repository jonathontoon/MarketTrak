//
//  Collectable.swift
//  
//
//  Created by Jonathon Toon on 6/2/16.
//
//

import Foundation
import CoreData

class Collectable: NSManagedObject {

    @NSManaged var name: String?
    @NSManaged var image: String?
    @NSManaged var desc: String?
    @NSManaged var type: String?
    @NSManaged var quality: String?

}
