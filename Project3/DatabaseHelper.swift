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
    let categories = ["New Arrivals","Shirts & Tops","Bottoms","Tanks & Stringers","Hoodies & Jackets","Underwear","Accessories","Last Chance", "Sports Bras","Leggings","Joggers","Shorts", "Men", "Women", "Unisex"]
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
            if check.count > 100 {
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
        for data in Men {
            let clothing = NSEntityDescription.insertNewObject(forEntityName: "Clothing", into: context!) as! Clothing
            print("adding : ", data)
            clothing.data = data
            clothing.id = data.id
            do {
                try context?.save()
                print("data saved")
            } catch let error {
                print("data not saved : ", error)
            }
        }
        for data in Women {
            let clothing = NSEntityDescription.insertNewObject(forEntityName: "Clothing", into: context!) as! Clothing
            print("adding : ", data)
            clothing.data = data
            clothing.id = data.id
            do {
                try context?.save()
                print("data saved")
            } catch let error {
                print("data not saved : ", error)
            }
        }
        for data in Unisex {
            let clothing = NSEntityDescription.insertNewObject(forEntityName: "Clothing", into: context!) as! Clothing
            print("adding : ", data)
            clothing.data = data
            clothing.id = data.id
            do {
                try context?.save()
                print("data saved")
            } catch let error {
                print("data not saved : ", error)
            }
        }
    }
    
    func fetchFilteredClothes(query : String) -> [ClothingObj]{
        var filtered = [ClothingObj]()
        var clothes = [Clothing]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Clothing")
        do {
            clothes = try context?.fetch(fetchReq) as! [Clothing]
            print("Data Fetched")
            for data in clothes {
                if data.data!.gender.contains(query) || data.data!.type.contains(query) || data.data!.name == query {
                    var exists : Bool = false
                    for obj in filtered {
                        print(obj.id," comparing ", data.data!.id)
                        if filtered.contains(where: {$0.id == data.data!.id}) {
                            print("exists")
                            exists = true
                        } else {
                            print("doesnt exist")
                            exists = false
                        }
                    }
                    if !exists {
                        filtered.append(data.data!)
                    }
                }
                //filtered.append(data.data!)
            }
            
        } catch {
            print("Error: Data not fetched")
        }

        print("returning : ", filtered)
        return filtered
    }
}
