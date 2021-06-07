//
//  transformData.swift
//  Project3
//
//  Created by Edward Guilllermo on 6/4/21.
//

import Foundation

@objc(NSAttributedStringTransformer)
public class NSAttributedStringTransformer: NSSecureUnarchiveFromDataTransformer {
    public override class var allowedTopLevelClasses: [AnyClass] {
        return super.allowedTopLevelClasses + [NSAttributedString.self]
    }
}
