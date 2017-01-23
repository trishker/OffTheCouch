//
//  DataModel.swift
//  OffTheCouch
//
//  Created by Trish Kernan on 19/01/2017.
//  Copyright © 2017 Trish Kernan. All rights reserved.
//

import Foundation

class DataModel {
    var actions = [ActionItem]()
    var accumulatedPoints = 0
    
    init() {
        loadActions()
    }
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).appendingPathComponent("actions.plist")
    }
    
    func saveActions() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(actions, forKey: "Actions")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    func loadActions() {
        let path = dataFilePath()
        if FileManager.default.fileExists(atPath: path) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                actions = unarchiver.decodeObject(forKey: "Actions") as! [ActionItem]
                unarchiver.finishDecoding()
            }
        }
    }
}
