//
//  Reviews+CoreDataProperties.swift
//  
//
//  Created by Edward Guilllermo on 6/6/21.
//
//

import Foundation
import CoreData


extension Reviews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reviews> {
        return NSFetchRequest<Reviews>(entityName: "Reviews")
    }

    @NSManaged public var comment: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: Float

}
