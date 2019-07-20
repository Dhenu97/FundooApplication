//
//  SlideViewTableController.swift
//  FundooApplication
//
//  Created by BridgeLabz on 20/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

class SlideViewTableController: UITableViewController {
    
    var arrname = ["delete","Reminder"]
    
    var colorData:[UIColor] = [#colorLiteral(red: 0.831372549, green: 0.1333333333, blue: 0.9411764706, alpha: 1) , #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) , #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) , #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) , #colorLiteral(red: 0.05098039216, green: 0.8196078431, blue: 0.05490196078, alpha: 1) , #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) , #colorLiteral(red: 1, green: 0.03529411765, blue: 0.2901960784, alpha: 1) , #colorLiteral(red: 0.5568627451, green: 0.6196078431, blue: 0.968627451, alpha: 1)]
    
    var color:String = "FFFFFF"



    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrname.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EditNavigationCell = tableView.dequeueReusableCell(withIdentifier:"editVC",for:indexPath) as! EditNavigationCell
        cell.nameLbl.text = arrname[indexPath.row]
        return cell
    }

}

extension SlideViewTableController:  UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colorCell:colorViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionVC", for: indexPath) as! colorViewCell
        colorCell.backgroundColor = colorData[indexPath.row]
       // colorCell.backgroundColor = UIColor.init(hex:EditViewController[indexPath.row] )

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
        view.backgroundColor = UIColor.init(hex: color)
        print("background")
    }
}

extension SlideViewTableController {
    
    enum enumcolors:String {
        case defaultvalue = "FFFFFF"
        case pink = "D422F0"
        case green = "579F2B"
        case skyBlue = "42C1F7"
        case yellow = "F5B433"
        case lightGreen = "0DD10E"
        case hash = "999999"
        case red = "FF094A"
        case violet = "8E9EF7"
        
        
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



