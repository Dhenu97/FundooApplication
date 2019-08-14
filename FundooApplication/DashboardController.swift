//
//  DashboardController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 10/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController

class DashboardController: UIViewController {
    
    
    var  userInfo:[String : Any]?

    @IBOutlet weak var sideMenu: UIBarButtonItem!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true;
        self.navigationController?.title = "Fundoo Notes"
        addNotesBtn.layer.cornerRadius = 20
        addNotesBtn.layer.masksToBounds = true
    
    }
    
   
    
    @IBAction func sideMenu(_ sender: Any) {
        
        self.present(MenuHelper.getSideMenu(), animated: true, completion: nil)
        SJSwiftSideMenuController.showLeftMenu()
    }

    
    
    @IBOutlet weak var addNotesBtn: UIButton!
    
    @IBAction func addNotesAction(_ sender: Any) {
        
        guard let navigation:EditViewController = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditViewController else { return  }
        navigationController?.pushViewController(viewController: navigation, animated: true, completion: ({
            navigation.isEditable = false
        }))
        
    }
    
    @IBAction func layoutChangedbtn(_ sender: UISegmentedControl) {
    NotificationCenter.default.post(name: NSNotification.Name("listgridView"), object: nil, userInfo: ["segmentIndex":sender.selectedSegmentIndex])
}
    
    @IBAction func signoutBtn(_ sender: Any) {
        guard let sideDown:SignOutController = storyboard?.instantiateViewController(withIdentifier: "signOutVC") as? SignOutController else {
            return
        }
        self.present(sideDown, animated: true) {

        }
    }
    
}


