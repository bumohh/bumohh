//
//  Users+CoreDataProperties.swift
//  
//
//  Created by Edward Guilllermo on 5/24/21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var balance: Float
    @NSManaged public var cart: [String]?
    @NSManaged public var mobileNumber: String?
    @NSManaged public var password: String?
    @NSManaged public var searchHistory: [String]?
    @NSManaged public var username: String?
    @NSManaged public var wishList: [String]?

}
