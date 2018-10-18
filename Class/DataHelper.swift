//
//  PlistHelper.swift
//  ONECard
//
//  Created by Dat Hoang on 06-07-2018.
//  Copyright © 2018 DatHoang. All rights reserved.
//

import UIKit

class DataHelper: NSObject {
    static public func GetStringFromPList(pListName:String,key:String) -> String{
        if let path = Bundle.main.path(forResource: pListName, ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                return dict[key] as! String
            }
        }
        return ""
    }
    
    static public func GetBooleanFromPList(pListName:String,key:String) -> Bool{
        if let path = Bundle.main.path(forResource: pListName, ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                return dict[key] as! Bool
            }
        }
        return false
    }
    
    static public func SetToUserDefault(key:String, value:Any){
         UserDefaults.standard.set(value, forKey: key)
    }
    
    static public func GetIntFromUserDefault(key:String) -> Int{
        return UserDefaults.standard.integer(forKey:key)
    }
    
    static public func GetBooleanFromUserDefault(key:String) -> Bool{
        return UserDefaults.standard.bool(forKey:key)
    }


}
