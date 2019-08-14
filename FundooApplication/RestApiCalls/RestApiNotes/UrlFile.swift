//
//  UrlFile.swift
//  FundooApplication
//
//  Created by BridgeLabz on 27/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation

var baseUrl = "http://34.213.106.173/api/"

enum pathVariable : String{
    case addNotes = "notes/addNotes"
    case getNotes = "notes/getNotesList"
    case updateNotes = "notes/updateNotes"
    case pinUnPinNotes = "notes/pinUnpinNotes"
    case reminderNotes = "notes/addUpdateReminderNotes"
    case archiveNotes = "notes/archiveNotes"
    case changeColorNotes = "changesColorNotes"
    case trashNotes = "notes/trashNotes"
    case profileURl = "user/uploadProfileImage"
    
}

