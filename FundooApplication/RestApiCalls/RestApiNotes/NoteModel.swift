//
//  AddNotes.swift
//  FundooApplication
//
//  Created by BridgeLabz on 19/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation

class NoteModel : Codable {
    var title:String
    var description:String
    var isPined:Bool
    var isArchived:Bool
    var color:String
     var reminder:String
    var isDelete:Bool
    
    init(title : String , Description : String , Color : String , isPin : Bool , Archive :Bool , Reminder:String , isDelete: Bool) {
        self.title = title
        self.description = Description
        self.color = Color
        self.isPined = isPin
        self.isArchived = Archive
        self.reminder = Reminder
        self.isDelete = isDelete
        //
        //        print("""
        //            "title" : \(title)
        //            "description" : \(Description)
        //            "isPined" : \(isPin)
        //            "isArchived" : \(Archive)
        //            "color" : \(Color)
        //            """)
        
    }
    
    var noteId:String!
    
    init(dict : [String : AnyObject]) {
        self.title = dict["title"] as! String
        self.description = dict["description"] as! String
        self.color = dict["color"] as! String
        self.isArchived = dict["isArchived"] as! Bool
        self.isPined = dict["isPined"]as! Bool
        self.noteId = (dict["id"] as! String)
        self.isDelete = dict["isDeleted"]as! Bool
        let remainderdict = dict["reminder"] as! [String]
        self.reminder = !remainderdict.isEmpty ? remainderdict[0]: ""
        
        
        print("""
            "title" : \(title)
            "description" : \(description)
            "id" : \(noteId ?? nil)
            "isPined": \(isPined)
            "color" : \(color)
            "reminder":\(reminder)
            """)
    }
    init(title : String , Description : String , Color : String , isPin : Bool , Archive :Bool , Reminder:String , isDelete: Bool , noteId:String) {
        self.title = title
        self.description = Description
        self.color = Color
        self.isPined = isPin
        self.isArchived = Archive
        self.reminder = Reminder
        self.isDelete = isDelete
        self.noteId = noteId
    
    }
}
