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
    
    
    func clothesExist() -> Bool {
        var check : [ClothingObj] = []
        var clothes = [Clothing]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Clothing")
        do {
            clothes = try context?.fetch(fetchReq) as! [Clothing]
            print("Data Fetched")
            for data in clothes {
                check.append(data.value(forKey: "data") as! ClothingObj)
            }
            if check.count > 0 {
                print("data exists")
                return true
            } else {
                print("no data")
                return false
            }
            
        } catch {
            print("Error: Data not fetched")
        }
        return false
    }
    
    func addClothes(Men : [ClothingObj], Women : [ClothingObj], Unisex : [ClothingObj]) {
        let clothing = NSEntityDescription.insertNewObject(forEntityName: "Clothing", into: context!) as! Clothing
        var counter = 0
        for data in Men {
            print("adding : ", Men[counter].price)
            clothing.data = Men[counter]
            clothing.id = Men[counter].id
            counter += 1
        }
        counter = 0
        for data in Women {
            print("adding : ", Women[counter].price)
            clothing.data = Women[counter]
            clothing.id = Women[counter].id
            counter += 1
        }
        counter = 0
        for data in Unisex {
            print("adding : ", Unisex[counter].price)
            clothing.data = Unisex[counter]
            clothing.id = Unisex[counter].id
            counter += 1
        }
        do {
            try context?.save()
            print("data saved")
        } catch let error {
            print("data not saved : ", error)
        }
    }
}
