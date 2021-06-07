//
//  OrderObj.swift
//  Project3
//
//  Created by Bruno Gomez on 6/5/21.
//

import Foundation
import UIKit

public class OrderObj : NSObject, NSCoding {
    var shippingInfo : shipInfoObj
    var cartInfo : [CartObj]
    var uniqueID: String
    
    init (shippingInfo : shipInfoObj, cartInfo : [CartObj], uniqueID : String) {
        self.shippingInfo = shippingInfo
        self.cartInfo = cartInfo
        self.uniqueID = uniqueID
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(shippingInfo, forKey: "shippingInfo")
        coder.encode(cartInfo, forKey: "cartInfo")
        coder.encode(uniqueID, forKey: "uniqueID")
    }
    
    required public init?(coder decod: NSCoder) {
        self.shippingInfo = decod.decodeObject(forKey: "shippingInfo") as! shipInfoObj
        self.cartInfo = decod.decodeObject(forKey: "cartInfo") as! [CartObj]
        self.uniqueID = decod.decodeObject(forKey: "uniqueID") as! String
    }
    
    
}
