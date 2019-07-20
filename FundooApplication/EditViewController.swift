//
//  EditViewController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 13/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    
    
    @IBOutlet weak var textfeildTxt: UITextField!
    
    
    @IBOutlet weak var descriptionTxtFeild: UITextField!
    
    
    var isPinned:Bool = false
    
    var isArchive:Bool = false
    

    
   var reuseIdentifier = "cell"

    var transparentView = UIView()
    
    var tableView = UITableView()
    
    let height: CGFloat = 250
    
    var isSideMenu = false
    
    @IBOutlet weak var topMenuConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func isArchive(_ sender: Any) {
        isArchive = !isArchive
        print(isArchive)
    }
    
    @IBAction func isPinned(_ sender: Any) {
        isPinned = !isPinned
        print(isPinned)
    }
    
    @IBAction func addReminder(_ sender: Any) {
        alertController()
        
    }
    
        @IBAction func slideUpBtn(_ sender: Any) {
        
    
        if isSideMenu {
            isSideMenu = false
            topMenuConstraint.constant = -128
            
        } else {
            isSideMenu = true
            topMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func alertController(){
        let alert = UIAlertController(title: "Notification", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Add Reminder..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let name = alert.textFields?.first?.text {
                print("Your name: \(name)")
            }
        }))
        
        self.present(alert, animated: true)


}
}

