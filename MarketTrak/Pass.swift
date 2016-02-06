//
//  Pass.swift
//  
//
//  Created by Jonathon Toon on 2/6/16.
//
//

import Foundation
import CoreData


class Pass: NSManagedObject {

    @NSManaged var collection: String?
    @NSManaged var desc: String?
    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var type: String?
    @NSManaged var image: String?

}
