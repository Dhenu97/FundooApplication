//
//  CollectionViewCell.swift
//  FundooApplication
//
//  Created by BridgeLabz on 25/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    @IBOutlet weak var notesTitle: UILabel!
    
    @IBOutlet weak var notesReminder: UILabel!
    
    @IBOutlet weak var notesDescription: UILabel!
    
    func bindNote(note : NoteModel){
        notesTitle.text! = note.title
        notesDescription.text! = note.description
        notesReminder.text! = note.reminder
        
        if (note.color.hasPrefix("#")) {
            let startIndex = note.color.index((note.color.startIndex), offsetBy: 1)
            let cellColor = String((note.color[startIndex...]))
            backgroundColor = UIColor.init(hex: cellColor)
        }
        
    }
  
}
