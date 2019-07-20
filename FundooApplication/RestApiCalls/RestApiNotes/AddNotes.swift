//
//  AddNotes.swift
//  FundooApplication
//
//  Created by BridgeLabz on 19/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation

class AddNotes:Codable {
    
    var addNotes = [AddNotes]()
    
    var titile = String()
    var description = String()
    var isPined = String()
    var isArchived = String()
    var color = String()
    var reminder = String()
    
    init(notesDetails: [String: Any]) {
        
        self.titile = notesDetails["titile"] as! String
        self.description = notesDetails["description"] as! String
        self.isPined = notesDetails["isArchived"] as! String
        self.isArchived = notesDetails["color"] as! String
        self.reminder = notesDetails["reminder"] as! String

    }
    
}
