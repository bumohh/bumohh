//
//  ClothingObj.swift
//  Project3
//
//  Created by Bruno Gomez on 5/25/21.
//

import Foundation
import UIKit

public class ClothingObj : NSObject, NSCoding {
    var name : String
    var price : Float
    var gender : [String]
    var type : [String]
    var id : String
    var color : Int64
    var image : UIImage
    
    init (name : String, price : Float, gender : [String], type : [String], id : String, image : UIImage, color : Int64 ) {
        self.name = name
        self.price = price
        self.gender = gender
        self.type = type
        self.id = id
        self.image = image
        self.color = color
    }
    
    func addType(newType : String) {
        self.type.append(newType)
    }
    func addGender(newGender : String) {
        self.gender.append(newGender)
    }
    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(price, forKey: "price")
        coder.encode(gender, forKey: "gender")
        coder.encode(type, forKey: "type")
        coder.encode(id, forKey: "id")
        coder.encode(image, forKey: "image")
        coder.encode(color, forKey: "color")
    }
    
    required public init?(coder decod: NSCoder) {
        self.name = decod.decodeObject(forKey: "name") as! String
        self.price = decod.decodeObject(forKey: "price") as! Float
        self.gender = decod.decodeObject(forKey: "gender") as! [String]
        self.type = decod.decodeObject(forKey: "type") as! [String]
        self.id = decod.decodeObject(forKey: "id") as! String
        self.image = (decod.decodeObject(forKey: "image") as? UIImage)!
        self.color = decod.decodeObject(forKey: "color") as! Int64
        
    }
    
    
}
