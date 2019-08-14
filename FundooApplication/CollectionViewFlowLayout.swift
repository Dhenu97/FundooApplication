//
//  CollectionViewFlowLayout.swift
//  FundooApplication
//
//  Created by BridgeLabz on 26/07/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import UIKit

enum CollectionDisplay {
    case listView
    case gridView
}

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    
    override func  invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
    
    var display : CollectionDisplay = .gridView {
        didSet {
            if display != oldValue{
                self.invalidateLayout()
            }
        }
    }
    
    convenience init(display : CollectionDisplay) {
        self.init()
        self.display = display
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        self.configLayout()
    }
    
    func configLayout(){
        switch display {
        case .listView :
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                self.itemSize = CGSize(width: collectionView.frame.width * 0.8, height: 150)
            }
            
        case .gridView:
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                let optimizedWidth = (collectionView.frame.width - minimumInteritemSpacing)/2
                self.itemSize = CGSize(width: optimizedWidth, height: optimizedWidth)
            }
        }
    }
    
}
