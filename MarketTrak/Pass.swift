//
//  Pass.swift
//  
//
//  Created by Jonathon Toon on 12/26/15.
//
//

import Foundation
import CoreData


class Pass: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var collection: String?
    @NSManaged var quality: String?
    @NSManaged var type: String?
    @NSManaged var desc: String?

}
