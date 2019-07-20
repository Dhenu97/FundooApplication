//
//  DashboardController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 10/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit
import DTGradientButton

class DashboardController: UIViewController {
    
    
    var  userInfo:[String : Any]?
    
    @IBOutlet weak var notesSearchBar: UIButton!
    
    @IBOutlet weak var listgrideview: UISegmentedControl!
    
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    
    @IBOutlet weak var namelbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true;
        addNotesBtn.setGradientBackgroundColors([UIColor(hex: "5B4AF5"), UIColor(hex: "26D4FF")], direction: DTImageGradientDirection.toBottom, for: UIControl.State.normal)
        addNotesBtn.layer.cornerRadius = 20
        addNotesBtn.layer.masksToBounds = true
        
        notesSearchBar.layer.cornerRadius = 20
        notesSearchBar.layer.masksToBounds = true
        
        
    }
    
    
    @IBAction func sideMenu(_ sender: Any) {
    }
    
    @IBOutlet weak var addNotesBtn: UIButton!
    
    @IBAction func addNotesAction(_ sender: Any) {
        
        guard let navigation:EditViewController = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditViewController else { return  }
        self.navigationController?.pushViewController(navigation, animated: true)
        
    }
    
    @IBAction func searchBarAction(_ sender: Any) {
    }
    
    
    @IBAction func buuton(_ sender: Any) {
        
        print(userInfo)
    }
    
}


