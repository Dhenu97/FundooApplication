//
//  ModelClass.swift
//  FundooApplication
//
//  Created by BridgeLabz on 11/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation

struct modeldata {
    var id: Int
    var name: String?
    var email: String?
    var mobilenumber:String?
    
    init(id: Int, name: String?, email: String?,mobilenumber:String?){
        self.id = id
        self.name = name
        self.email = email
        self.mobilenumber = mobilenumber
        
    }
    
    
}
