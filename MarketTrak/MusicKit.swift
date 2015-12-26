//
//  MusicKit.swift
//  
//
//  Created by Jonathon Toon on 12/26/15.
//
//

import Foundation
import CoreData


class MusicKit: NSManagedObject {

    @NSManaged var objectId: String?
    @NSManaged var artistName: String?
    @NSManaged var hasStatTrak: NSNumber?
    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var type: String?

}
