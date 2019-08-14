//
//  CoreDataHelper.swift2
//  FundooApplication
//
//  Created by BridgeLabz on 08/08/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper{
    
    static var arrnote : [NSManagedObject] = []
    
    static var listOfNotes:[NoteModel]=[]
    
    
    static var appdel:AppDelegate!
    static var entityDescription:NSEntityDescription!
    static var mobj:NSManagedObjectContext!
    private static func initContext() {
       
    }

    static func saveToDb(note: NoteModel)
    {
        CoreDataHelper.appdel=UIApplication.shared.delegate as? AppDelegate
        CoreDataHelper.mobj = CoreDataHelper.appdel.persistentContainer.viewContext

        entityDescription = NSEntityDescription.entity(forEntityName: "Notes", in: mobj)
        
        let notes = NSManagedObject(entity: entityDescription!, insertInto: mobj)
        notes.setValue(note.title, forKey: "noteTitle")
        
        notes.setValue(note.description, forKey:"noteDesc")
        
        notes.setValue(note.color, forKey:"noteColor")
        
        notes.setValue(note.reminder, forKey: "noteRemainder")
        
        notes.setValue(note.isPined, forKey: "isPined")
        
        notes.setValue(note.isArchived, forKey: "isArchived")
        
        notes.setValue(note.noteId, forKey: "noteId")
        
        notes.setValue(note.isDelete, forKey: "isDelete")
        
        do{
            try mobj!.save()
            arrnote.append(notes)
            
            print("DONE SAVING TO COREDATA")
        }catch{
            
            print("ERROR SAVING TO COREDATA")
            
        }
        
    }
    
    static func deleteDbNotes()
    {
        CoreDataHelper.appdel=UIApplication.shared.delegate as? AppDelegate
        CoreDataHelper.mobj = CoreDataHelper.appdel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do
        {
            try mobj!.execute(batchDeleteRequest)
            print("Deleted all objects from coredata")
            
        } catch
        {
            print("Error deleting all data from coredata")
        }
        
    }
    
    static func getDbNotes(fetchOffset : Int)->[NoteModel]
    {
        CoreDataHelper.appdel=UIApplication.shared.delegate as? AppDelegate
        CoreDataHelper.mobj = CoreDataHelper.appdel.persistentContainer.viewContext
        var listOfNotes:[NoteModel]=[]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Notes")
        fetchRequest.fetchLimit = 5
        fetchRequest.fetchOffset = fetchOffset
        do {
            let listOfDnNotes = try mobj!.fetch(fetchRequest) as! [NSManagedObject]
            for dbNote in listOfDnNotes{
                let noteId = dbNote.value(forKey: "noteId") as! String
                let noteTitle = dbNote.value(forKey: "noteTitle") as! String
                let noteDescription = dbNote.value(forKey: "noteDesc") as! String
                let noteColor = dbNote.value(forKey: "noteColor") as! String
                let noteReminder = dbNote.value(forKey: "noteRemainder") as! String
                let notepin = dbNote.value(forKey: "isPined") as! Bool
                let noteArchive = dbNote.value(forKey: "isArchived") as! Bool
                let noteTrash = dbNote.value(forKey: "isDelete") as! Bool

                let foundNote = NoteModel.init(title: noteTitle, Description: noteDescription, Color: noteColor, isPin: notepin, Archive: noteArchive, Reminder: noteReminder, isDelete: noteTrash, noteId: noteId)
                print("printing coredata")
                print(foundNote)
                listOfNotes.append(foundNote)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        return listOfNotes
    }
}
