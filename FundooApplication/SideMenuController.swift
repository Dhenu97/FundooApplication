//
//  SideMenuController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 27/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController {
    
    var arrNames = ["home","Reminder","Archive","Pin","Trash"]
    var arrImages = [#imageLiteral(resourceName: "icons8-idea-24"),#imageLiteral(resourceName: "reminder"),#imageLiteral(resourceName: "archive"),#imageLiteral(resourceName: "pin"),#imageLiteral(resourceName: "email")]
    var listOfNotes = [NoteModel]()
    


    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
extension SideMenuController:UITableViewDelegate,UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as! SideMenuCell
        cell.imageLbl.image = arrImages[indexPath.row]
        cell.nameLbl.text! = arrNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var index:Int
        
        switch indexPath.row {
        case sideMenu.notes.rawValue:
            index = sideMenu.notes.rawValue
        case sideMenu.reminder.rawValue:
            index = sideMenu.reminder.rawValue
        case sideMenu.archive.rawValue:
            index = sideMenu.archive.rawValue
        case  sideMenu.trash.rawValue:
            index = sideMenu.trash.rawValue
            break
            
        default:
           index = sideMenu.notes.rawValue
        }
        NotificationCenter.default.post(name: NSNotification.Name("showNotes"), object: nil, userInfo: ["index": index])
  
    }
    
    func showNotes(){
        
    }
    
}

extension SideMenuController{
    enum sideMenu : Int {
        case notes
        case reminder
        case archive
        case trash
    }
}
