//
//  ClothingObj.swift
//  Project3
//
//  Created by Bruno Gomez on 5/25/21.
//

import Foundation
import UIKit

public class CartObj : NSObject, NSCoding {
    var size : String
    var name : String
    var price : Float
    var id : String
    var image : UIImage
    
    init (name : String, price : Float, id : String, image : UIImage, size : String ) {
        self.name = name
        self.price = price
        self.id = id
        self.image = image
        self.size = size
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(price, forKey: "price")
        coder.encode(id, forKey: "id")
        coder.encode(image, forKey: "image")
        coder.encode(size, forKey: "size")
    }
    
    required public init?(coder decod: NSCoder) {
        self.name = decod.decodeObject(forKey: "name") as! String
        self.price = decod.decodeFloat(forKey: "price")
        self.id = decod.decodeObject(forKey: "id") as! String
        self.image = (decod.decodeObject(forKey: "image") as? UIImage)!
        self.size = decod.decodeObject(forKey: "size") as! String
        
    }
    
    
}
