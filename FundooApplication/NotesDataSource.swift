//
//  NotesDataSource.swift
//  FundooApplication
//
//  Created by BridgeLabz on 07/08/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

protocol DataSource {
    var listsOfNotes : [[NoteModel]] {get set}
    var cell : NotesCollectionViewCell {get set}
    
    init(listsOfNotes : [[NoteModel]], cell : NotesCollectionViewCell)
}

class NotesDataSource : NSObject, DataSource ,UICollectionViewDataSource {
    var listsOfNotes: [[NoteModel]]
    
    var cell: NotesCollectionViewCell
    
    required init(listsOfNotes: [[NoteModel]], cell: NotesCollectionViewCell) {
        self.listsOfNotes = listsOfNotes
        self.cell = cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listsOfNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listsOfNotes[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cell.bindNote(note: listsOfNotes[indexPath.section][indexPath.row])
        return cell
    }
}
