//
//  UserDefaultManager.swift
//  FundooApplication
//
//  Created by BridgeLabz on 07/08/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation

class UserDefaultManager {
    
    
   static func setValue(value:Any , key:String){
        
        UserDefaults.standard.set(value, forKey: key)
        
    }
    
   static func retriveValue(key:String)->Any{
    
    let defaults = UserDefaults.standard
    let retrivedValue =  defaults.value(forKey: key)
    return retrivedValue
    }
    
   static func removeValue(key:String){
        UserDefaults.standard.removeObject(forKey: key)
    }
}
