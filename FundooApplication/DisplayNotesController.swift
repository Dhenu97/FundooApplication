//
//  DisplayNotesController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 22/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit
import MaterialComponents
import SJSwiftSideMenuController


fileprivate let searchBarHeight:Int = 40

class DisplayNotesController: UICollectionViewController , UICollectionViewDelegateFlowLayout , UISearchControllerDelegate {
    
    lazy var collectionViewFlowLayout : CollectionViewFlowLayout = {
        let layout = CollectionViewFlowLayout(display: .listView)
        return layout
    }()
    
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    var isSearching:Bool = false
    
    var listOfNotes = [NoteModel]()
    
    var pinnedNotes = [NoteModel]()
    
    var deleteNotes = [NoteModel]()
    
    var reminderNotes = [NoteModel]()
    
    var searchFilter = [NoteModel]()
    
    var archiveNotes = [NoteModel]()
    
    var totalCount = 0
    var fetchOffset = 0
    override func viewDidLoad() {
        self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "displayCell")
        addObserver()
        searchBarSetUp()
        activityindicator.isHidden = true
        
    }
    
    func searchBarSetUp(){
        let searchBar = UISearchBar(frame: CGRect (x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: searchBarHeight))
        view.addSubview(searchBar)
        searchBar.delegate = self
        
    }
    
    
    func addObserver()  {
        
        NotificationCenter.default.addObserver(self, selector: #selector(getList(notification:)), name: NSNotification.Name("NoteList"), object: nil)
        print("note list loading")
        
        NotificationCenter.default.addObserver(self, selector: #selector(listview(notification:)), name: NSNotification.Name("listgridView"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showNotes(notification:)), name: NSNotification.Name("showNotes"), object: nil)
        
    }
    
    @objc func listview(notification : NSNotification){
        let segmentIndex:Int  = notification.userInfo!["segmentIndex"] as! Int
        switch segmentIndex {
        case 0 :
            self.collectionViewFlowLayout.display = .listView
        case 1 :
            self.collectionViewFlowLayout.display = .gridView
        default :
            self.collectionViewFlowLayout.display = .listView
        }
    }
    
    @objc func getList(notification:Notification){
        print("notification observed for list")
        let noteList = notification.userInfo!["List"] as! [NoteModel]
        print("num\(listOfNotes.count)")
        print("no of notes\(noteList.count)")
        DispatchQueue.main.async {
            CoreDataHelper.deleteDbNotes()
            for list in noteList{
                CoreDataHelper.saveToDb(note:list)
                
            }
        }
        totalCount = noteList.count
    }
    
    @objc func showNotes(notification:Notification){
        let index = notification.userInfo!["index"] as! Int
        
        switch index {
        case 0:
            SJSwiftSideMenuController.hideLeftMenu()
            listOfNotes = listOfNotes.filter({ (note) -> Bool in
                return !note.isArchived && !note.isDelete
            })
            collectionView.reloadData()
        case 1:
            SJSwiftSideMenuController.hideLeftMenu()
            listOfNotes = listOfNotes.filter({ (note) -> Bool in
                return !note.reminder.isEmpty
            })
            collectionView.reloadData()
        case 2:
            SJSwiftSideMenuController.hideLeftMenu()
            listOfNotes = listOfNotes.filter({ (archiveNotes) -> Bool in
                return archiveNotes.isArchived
            })
            collectionView.reloadData()
        case 3:
            SJSwiftSideMenuController.hideLeftMenu()
            deleteNotes = listOfNotes.filter({ (note) -> Bool in
                return !note.isDelete
            })
            collectionView.reloadData()
            break
            
        default:
            SJSwiftSideMenuController.hideLeftMenu()
            listOfNotes = listOfNotes.filter({ (note) -> Bool in
                return  !note.isArchived && !note.isDelete
            })
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        AddNotesApiCall.getNotesFromserver()
        listOfNotes = CoreDataHelper.getDbNotes(fetchOffset:  fetchOffset)
        collectionView.reloadData()
    }
    
    
    func registerCellNib()
    {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "displayCell")
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching{
            return searchFilter.count
        }
        return listOfNotes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:NotesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "displayCell", for: indexPath) as! NotesCollectionViewCell
        if isSearching{
            let note1 = searchFilter[indexPath.row]
            cell.bindNote(note: note1)
        }
        else {
            cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
            UIView.animate(withDuration: 0.5, animations: {
                cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
            },completion: { finished in
                UIView.animate(withDuration: 0.1, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1,1,1)
                })
            })
            cell.layer.cornerRadius = 10
            cell.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            let note1 = listOfNotes[indexPath.row]
            cell.bindNote(note: note1)
        }
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! NotesCollectionViewCell
        
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
        
        if isSearching{
            let note1 = searchFilter[indexPath.row]
            
            
            let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as! EditViewController
            editVC.noteToEdit = note1
            bindData(controller: editVC, note:note1 )
            self.present(editVC, animated: true, completion: nil)
        }
        else{
            let note1 = listOfNotes[indexPath.row]
            
            let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as! EditViewController
            editVC.noteToEdit = note1
            bindData(controller: editVC, note:note1 )
            self.present(editVC, animated: true, completion: nil)
        }
    }
    
    func bindData(controller:EditViewController , note:NoteModel){
        controller.noteToEdit = note
        controller.isEditable = true
        if (note.color.hasPrefix("#")) {
            let startIndex = note.color.index((note.color.startIndex), offsetBy: 1)
            let cellColor = String((note.color[startIndex...]))
            controller.setcolor(color: cellColor)
        }
        
    }
    
    
    func progressBar(){
        activityindicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        self.view.bringSubviewToFront(activityindicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 50.0 {
            activityindicator.startAnimating()
            collectionView.addSubview(activityindicator)
            activityindicator.isHidden = false
            if listOfNotes.count < totalCount {
                fetchOffset = fetchOffset + 5
                activityindicator.stopAnimating()
                activityindicator.isHidden = true
                let list = CoreDataHelper.getDbNotes(fetchOffset: fetchOffset)
                for i in 0..<list.count {
                    listOfNotes.append(list[i])
                }
                collectionView.reloadData()
            }
        }
    }
}
