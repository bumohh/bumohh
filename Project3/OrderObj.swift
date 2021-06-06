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
    
    init (shippingInfo : shipInfoObj, cartInfo : [CartObj]) {
        self.shippingInfo = shippingInfo
        self.cartInfo = cartInfo
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(shippingInfo, forKey: "shippingInfo")
        coder.encode(cartInfo, forKey: "cartInfo")
    }
    
    required public init?(coder decod: NSCoder) {
        self.shippingInfo = decod.decodeObject(forKey: "shippingInfo") as! shipInfoObj
        self.cartInfo = decod.decodeObject(forKey: "cartInfo") as! [CartObj]
    }
    
    
}
