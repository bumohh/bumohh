//
//  Guests+CoreDataProperties.swift
//  
//
//  Created by Bruno Gomez on 5/25/21.
//
//

import Foundation
import CoreData


extension Guests {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Guests> {
        return NSFetchRequest<Guests>(entityName: "Guests")
    }

    @NSManaged public var cart: String?
    @NSManaged public var searchHistory: String?

}
