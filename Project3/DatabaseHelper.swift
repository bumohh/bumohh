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
    static var arrOfComments = [String]()
    static var arrOfRatings = [Float]()
    static var arrOfNames = [String]()
    
    func saveReview(id: String, rating: Float, comment: String, name: String) {
        let review = NSEntityDescription.insertNewObject(forEntityName: "Reviews", into: context!) as! Reviews
        //DatabaseHelper.arrOfRatings.append(rating)
        //DatabaseHelper.arrOfComments.append(comment)
        //DatabaseHelper.arrOfNames.append(name)
        review.id = id
        review.rating = rating
        review.comment = comment
        review.name = name
        do {
            print(review.id, review.rating, review.comment, review.name)
            try context?.save()
            print("Review Id, Rating, Comment, and Name Data saved")
        }
        catch{
            print("Data not saved")
        }
    }
    
    func fetchReview() -> [Reviews] {
        var review = [Reviews]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Reviews")
        do {
            review = try context?.fetch(fetchReq) as! [Reviews]
            print("Reviews Data Fetched")
        }
        catch {
            print("Cannot Fetch Data")
        }
        return review
    }
    
    func saveNewUser(object : [String : String], number : String) {
        let user = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context!) as! Users
        user.username = object["username"]
        user.password = object["password"]
        user.mobileNumber = number
        user.cart = []
        user.balance = 0
        user.searchHistory = []
        user.wishList = []
        user.shipInfo = []
        user.orders = []
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
    
    func fetchClothesById(id : String) -> ClothingObj{
        let errorObj = ClothingObj(name: "", price: -1, gender: [], type: [], id: "", image: UIImage(systemName: "xmark")!, color: -1)
        var clothes = [Clothing]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Clothing")
        do {
            clothes = try context?.fetch(fetchReq) as! [Clothing]
            print("data fetched")
            for data in clothes {
                if data.data!.id == id {
                    return data.data!
                } else {
                }
            }
        } catch {
            print("data not fetched")
        }
        return errorObj
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
                        if filtered.contains(where: {$0.id == data.data!.id}) {
                            exists = true
                        } else {
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

        return filtered
    }
    // MARK:- User Cart
    func fetchUserCart(currUser : String) -> [CartObj] {
        let errorData = [CartObj(name: "", price: -1, id: "", image: UIImage(systemName: "xmark")!, size: "")]
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            if currUser == "Guest" {
                return ViewController.GuestCart
            } else {
            for data in users {
                if data.username == currUser {
                    return data.cart!
                }
            }
        }
        } catch {
            print("error, data not fetched")
        }
        return errorData
    }
    
    func addToCart(obj : CartObj, currUser : String) {
        print("adding to cart for : ", currUser)
        var user = [Users]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            if currUser == "Guest" {
                print("added ", obj.id, "to guest cart")
                ViewController.GuestCart.append(obj)
            } else {
                for data in users {
                 if data.username == currUser {
                    data.cart?.append(obj)
                    print("added ", obj.id, " to cart")
                    do {
                        try context?.save()
                        print("data saved")
                    } catch let error {
                        print("error data not saved ", error)
                        }
                    }
                }
            }
        } catch {
            print("error, data not fetched")
        }
    }
    func removeFromCart(obj : CartObj, currUser : String) {
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            if currUser == "Guest" {
                let index = ViewController.GuestCart.firstIndex(where: {$0.id == obj.id && $0.size == obj.size})!
                ViewController.GuestCart.remove(at: index)
                print("removed ", obj.id, " from guest cart")
            } else {
            for data in users {
                if data.username == currUser {
                    let index = (data.cart?.firstIndex(where: {$0.id == obj.id && $0.size == obj.size})!)!
                    data.cart?.remove(at: index)
                    print("removed ", obj.id, " from cart")
                    do {
                        try context?.save()
                        print("data saved")
                    } catch let error {
                        print("error data not saved ", error)
                    }
                    }
                }
            }
            } catch {
            print("error, data not fetched")
        }
        
    }
    
    func removeAllFromCart(currUser : String) {
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            if currUser == "Guest" {
                ViewController.GuestCart.removeAll()
            } else {
            for data in users {
                if data.username == currUser {
                    data.cart!.removeAll()
                    do {
                        try context?.save()
                        print("data deleted and saved")
                    } catch let error {
                        print("error data not deleted or saved ", error)
                    }
                    }
                }
            }
            } catch {
            print("error, data not fetched")
        }
        
    }
    // MARK:- User Wish List
    func fetchUserWishList(currUser : String) -> [ClothingObj] {
        let errorData = [ClothingObj(name: "", price: -1, gender: [""], type: [""], id: "", image: UIImage(systemName: "xmark")!, color: -1)]
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            for data in users {
                if data.username == currUser {
                    return data.wishList!
                }
            }
        } catch {
            print("error, data not fetched")
        }
        return errorData
        
        
    }
    func addToWishList(obj: ClothingObj, currUser : String) {
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            for data in users {
                if data.username == currUser {
                    data.wishList?.append(obj)
                    print("added ", obj.id, " to wishList")
                    do {
                        try context?.save()
                        print("data saved")
                    } catch let error {
                        print("error data not saved ", error)
                    }
                }
            }
        } catch {
            print("error, data not fetched")
        }
        
    }
    
    func removeFromWishList(obj : ClothingObj, currUser : String) {
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            for data in users {
                if data.username == currUser {
                    data.wishList?.removeAll(where: {
                        $0.id == obj.id
                    })
                    print("removed ", obj.id, " from wishList")
                    do {
                        try context?.save()
                        print("data saved")
                    } catch let error {
                        print("error data not saved ", error)
                    }
                }
            }
        } catch {
            print("error, data not fetched")
        }
        
    }
    
    //MARK:- Shipping
    func addShipping(currUser: String, obj: shipInfoObj) {
        var user = [Users]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            for u in users {
                if (u.username == currUser) {
                    u.shipInfo?.append(obj)
                    print("shippingInfo added to array")
                    do {
                        try context?.save()
                        print("Saved shipInfo")
                    }
                    catch {
                        print("Did not save")
                    }
                }
            }
        }
        catch {
            print("Error")
        }
    }
    
    func checkShipping(currUser: String) -> Bool {
        var user = [Users]()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            for u in users {
                if u.username == currUser {
                if u.shipInfo!.count > 0 {
                    return true
                } else {
                    return false
                }
            }
            }
        }
        catch {
            print("Error")
        }
        print("error checking shipping info returning false")
        return false
    }
    
    
    func fetchShippingInfo(currUser: String) -> [shipInfoObj] {
        var shipData = [shipInfoObj(name: "", phoneNumber: "", address: "",  city: "", postalCode: "")]
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            print("User Logged in: \(ViewController.currentUserLogged)")
            for u in users {
                if u.username == currUser {
                    return u.shipInfo!
                }
            }
        }
        catch {
            print("Error no data fetched")
        }
        return shipData
    }
    
    func doesExistInWishList(id : String, currUser : String) -> Bool {
        
            let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
            do {
                let users = try context?.fetch(fetchReq) as! [Users]
                for data in users {
                    if data.username == currUser {
                        if data.wishList!.contains(where: {
                            $0.id == id
                        }) {
                            return true
                        } else {
                            return false
                        }
                    }
                }
            } catch {
                print("error, data not fetched")
            }
        return false
    }
    
    //MARK: - Orders
    func addOrder(currUser : String, shippingInfo : shipInfoObj, cart : [CartObj]) {
        let newOrder = OrderObj(shippingInfo: shippingInfo, cartInfo: cart)
        
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            for data in users {
                if data.username == currUser {
                    data.orders?.append(newOrder)
                    do {
                        try context?.save()
                        print("Added to order")
                    }
                    catch {
                        print("failed to add to order")
                    }
                }
            }
        } catch let error {
            print("failed to fetch data, error : ", error)
        }
        
    }
    
    func fetchOrderForUser(currUser : String) -> [OrderObj]{
        
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        do {
            let users = try context?.fetch(fetchReq) as! [Users]
            for data in users {
                if data.username == currUser {
                    print("returned orders for user :", currUser)
                    return data.orders!
                }
            }
        } catch let error {
            print("failed to fetch data, error : ", error)
        }
        let errorObj : [OrderObj] = []
        print("returning error orders")
        return errorObj
        
    }
}
