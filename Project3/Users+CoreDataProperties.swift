//
//  Users+CoreDataProperties.swift
//  
//
//  Created by Bruno Gomez on 5/27/21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var balance: Float
    @NSManaged public var cart: [CartObj]?
    @NSManaged public var mobileNumber: String?
    @NSManaged public var password: String?
    @NSManaged public var searchHistory: [ClothingObj]?
    @NSManaged public var username: String?
    @NSManaged public var wishList: [ClothingObj]?

}
