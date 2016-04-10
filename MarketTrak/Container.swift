//
//  Container.swift
//  
//
//  Created by Jonathon Toon on 2/6/16.
//
//

import Foundation
import CoreData


class Container: NSManagedObject {

    @NSManaged var collection: String?
    @NSManaged var items: NSDictionary?
    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var tournament: String?
    @NSManaged var type: String?
    @NSManaged var desc: String?
    @NSManaged var image: String?
    @NSManaged var containerSeries: NSNumber?
    @NSManaged var stickerCollection: String?

}
