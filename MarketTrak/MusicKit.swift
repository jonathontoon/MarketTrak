//
//  MusicKit.swift
//  
//
//  Created by Jonathon Toon on 2/6/16.
//
//

import Foundation
import CoreData


class MusicKit: NSManagedObject {

    @NSManaged var artistName: String?
    @NSManaged var hasStatTrak: NSNumber?
    @NSManaged var name: String?
    @NSManaged var quality: String?
    @NSManaged var type: String?
    @NSManaged var desc: String?
    @NSManaged var image: String?

}
