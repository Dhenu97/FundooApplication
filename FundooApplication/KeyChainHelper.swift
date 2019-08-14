//
//  KeyChainOperations.swift
//  FundooApplication
//
//  Created by BridgeLabz on 25/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import UIKit
import Security
import KeychainAccess

class KeyChainHelper{
    
   static func setValue(service:String , value: String , key:String){
        let keychain = Keychain(service: service)
        do {
            try keychain.set(value, key: key)
        }
        catch let error {
            print(error)
        }

    }
  static func getValue(service:String , key:String)->String{
    
    var retriveString = String()
            let keyChain = Keychain(service: service)
        do {
            try retriveString = keyChain.get(key)!
            print(key)
        }
        catch let error {
            print(error)
        }

    return retriveString
    }
    
    static func removeValues(service : String) {
        do {
            let keyChain = Keychain(service: service)
            try keyChain.removeAll()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
}
