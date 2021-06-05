//
//  shipInfoObj.swift
//  Project3
//
//  Created by Edward Guilllermo on 6/4/21.
//

import Foundation
import UIKit

public class shipInfoObj: NSObject, NSCoding {
    
    var name: String
    var phoneNumber: String
    var address: String
    var total: Float
    var city: String
    var postalCode: String
    
    init(name: String, phoneNumber: String, address: String, total: Float, city: String, postalCode: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
        self.total = total
        self.city = city
        self.postalCode = postalCode
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(phoneNumber, forKey: "phoneNumber")
        coder.encode(address, forKey: "address")
        coder.encode(total, forKey: "total")
        coder.encode(city, forKey: "city")
        coder.encode(postalCode, forKey: "postalCode")
    }
    
    required public init?(coder decod: NSCoder) {
        self.name = decod.decodeObject(forKey: "name") as! String
        self.phoneNumber = decod.decodeObject(forKey: "phoneNumber") as! String
        self.address = decod.decodeObject(forKey: "address") as! String
        self.total = decod.decodeFloat(forKey: "total")
        self.city = decod.decodeObject(forKey: "city") as! String
        self.postalCode = decod.decodeObject(forKey: "postalCode") as! String
    }
    
}
