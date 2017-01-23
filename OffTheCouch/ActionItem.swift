//
//  ActionItem.swift
//  OffTheCouch
//
//  Created by Trish Kernan on 14/01/2017.
//  Copyright © 2017 Trish Kernan. All rights reserved.
//

import Foundation

class ActionItem: NSObject, NSCoding {
    var text = ""
    var points = 0
    var checked = false
    var numberOfChecks = 0
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        points = aDecoder.decodeInteger(forKey: "Points")
        checked = aDecoder.decodeBool(forKey: "Checked")
        numberOfChecks = aDecoder.decodeInteger(forKey: "NumberOfChecks")
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(points, forKey: "Points")
        aCoder.encode(checked, forKey: "Checked")
        aCoder.encode(numberOfChecks, forKey: "NumberOfChecks")
    }

}
