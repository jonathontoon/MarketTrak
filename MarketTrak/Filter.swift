//
//  Filter.swift
//  
//
//  Created by Jonathon Toon on 12/31/15.
//
//

import Foundation
import CoreData


class Filter: NSManagedObject {

    @NSManaged var objectId: String?
    @NSManaged var category: String?
    @NSManaged var name: String?
    @NSManaged var options: NSArray?
    
}
