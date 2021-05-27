//
//  Clothing+CoreDataProperties.swift
//  
//
//  Created by Bruno Gomez on 5/25/21.
//
//

import Foundation
import CoreData


extension Clothing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clothing> {
        return NSFetchRequest<Clothing>(entityName: "Clothing")
    }

    @NSManaged public var id: Int64
    @NSManaged public var data: ClothingObj?

}
