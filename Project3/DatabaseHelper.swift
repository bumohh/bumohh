//
//  DatabaseHelper.swift
//  Project3
//
//  Created by Edward Guilllermo on 5/24/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static var inst = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveNewUser(object : [String : String], number : String) {
        let user = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context!) as! Users
        user.username = object["username"]
        user.password = object["password"]
        user.mobileNumber = number
        do {
            try context?.save()
            print("Sign Up Successful")
        }
        catch {
            print("Sign Up Failed")
        }
    }
    
    func updateUserPassword(object : [String : String]) {
        var user = Users()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        fetchReq.predicate = NSPredicate(format: "username == %@", object["username"]!)
        do {
            let res = try context?.fetch(fetchReq)
            if (res?.count != 0) {
                user = res?.first as! Users
                user.password = object["password"]
                try context?.save()
            }
            
        } catch {
            print("fetch failed")
        }
        
    }
    
    func fetchAllUserData() -> [Users] {
        var user = [Users]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            user = try context?.fetch(fetchReq) as! [Users]
            print("Data Fetched")
        }
        catch {
            print("Cannot Fetch Data")
        }
        return user
    }
    
    func fetchAllClothes() {
        var clothes = [Clothing]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Clothing")
        do {
            clothes = try context?.fetch(fetchReq) as! [Clothing]
            print("Data Fetched")
        } catch {
            print("Error: Data not fetched")
        }
    }
}
