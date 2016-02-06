//
//  Gift.swift
//  
//
//  Created by Jonathon Toon on 2/6/16.
//
//

import Foundation
import CoreData


class Gift: NSManagedObject {

    @NSManaged var desc: String?
    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var type: String?
    @NSManaged var image: String?
    @NSManaged var containerSeries: NSNumber?

}
