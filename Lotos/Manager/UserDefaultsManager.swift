//
//  UserDefaultsManager.swift
//  TTVKAPI
//
//  Created by Andrey Torlopov on 06/04/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import Foundation

class UserDefaultsManager: NSObject {

    class func setObject(key: String, value: AnyObject) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(value, forKey: key)
        ud.synchronize()
    }
    
    class func object(key: String) -> AnyObject? {
        let ud = NSUserDefaults.standardUserDefaults()
        return ud.objectForKey(key)
    }
    
    class func setBool(key: String, value:Bool) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setBool(value, forKey: key)
        ud.synchronize()
    }
    
    class func bool(key: String) -> Bool {
        let ud = NSUserDefaults.standardUserDefaults()
        return ud.boolForKey(key)
    }
    
    class func setString(key: String, value:String) {
        self.setObject(key, value: value)
    }
    
    class func string(key: String) -> String {
        var result = ""
        if let str = self.object(key) as? String {
            result = str
        } else {
            result = ""
        }
        return result
    }
}