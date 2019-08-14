//
//  SlideViewTableController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 20/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class SlideViewTableController: UITableViewController {
    
    var arrname = ["delete"]
    
    var colorData:[UIColor] = [#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) , #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) , #colorLiteral(red: 0.968627451, green: 0.9333333333, blue: 0.1568627451, alpha: 1) , #colorLiteral(red: 0.5191938212, green: 0.9764705896, blue: 0.9438369489, alpha: 1) , #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) , #colorLiteral(red: 0.6745098039, green: 0.568627451, blue: 0.968627451, alpha: 1) , #colorLiteral(red: 0.9098039216, green: 0.568627451, blue: 0.8549019608, alpha: 1) , #colorLiteral(red: 0.8549019608, green: 0.8039215686, blue: 0.8, alpha: 1)]
    
    var color:String = "#FFFFFF"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrname.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrname.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableEditNavigationCell = tableView.dequeueReusableCell(withIdentifier:"TableEditVC",for:indexPath) as! TableEditNavigationCell
        cell.nameLbl.text = arrname[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            NotificationCenter.default.post(name: NSNotification.Name("deleteNotes"), object: nil)
        print("posting trash notes")
    }
}

extension SlideViewTableController:  UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let colorCell:colorViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionVC", for: indexPath) as! colorViewCell
        
        colorCell.backgroundColor = colorData[indexPath.row]
        
        return colorCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("setting background color")
        switch indexPath.row {
        case Indexcolor.pink.rawValue:
            color = enumcolors.pink.rawValue
        case Indexcolor.green.rawValue:
            color = enumcolors.green.rawValue
        case Indexcolor.skyBlue.rawValue:
            color = enumcolors.skyBlue.rawValue
        case Indexcolor.yellow.rawValue:
            color = enumcolors.yellow.rawValue
        case Indexcolor.lightGreen.rawValue:
            color = enumcolors.lightGreen.rawValue
        case Indexcolor.hash.rawValue:
            color = enumcolors.hash.rawValue
        case Indexcolor.red.rawValue:
            color = enumcolors.red.rawValue
        case Indexcolor.violet.rawValue:
            color = enumcolors.violet.rawValue
            
            
            
        default:color = enumcolors.defaultvalue.rawValue
            
        }
        NotificationCenter.default.post(name: NSNotification.Name("ColorData"), object: nil, userInfo: ["color":color])
        print("color data loading")
        view.backgroundColor = UIColor.init(hex: color)
        tableView.backgroundColor = UIColor.init(hex: color)
        print("background")
    }
    
}

extension SlideViewTableController {
    
    enum enumcolors:String {
        case defaultvalue = "FFFFFF"
        case pink = "F07F5A"
        case green = "F5B433"
        case skyBlue = "F7EE28"
        case yellow = "84F9F1"
        case lightGreen = "95D26B"
        case hash = "AC91F7"
        case red = "E891DA"
        case violet = "DACDCC"
        
        
    }
    
    enum Indexcolor:Int {
        case pink = 0
        case green = 1
        case skyBlue = 2
        case yellow = 3
        case lightGreen = 4
        case hash = 5
        case red = 6
        case violet = 7
    }
}



