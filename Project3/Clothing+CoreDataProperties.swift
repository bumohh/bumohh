//
//  Clothing+CoreDataProperties.swift
//  
//
//  Created by Bruno Gomez on 6/5/21.
//
//

import Foundation
import CoreData


extension Clothing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clothing> {
        return NSFetchRequest<Clothing>(entityName: "Clothing")
    }

    @NSManaged public var data: ClothingObj?
    @NSManaged public var id: String?

}
