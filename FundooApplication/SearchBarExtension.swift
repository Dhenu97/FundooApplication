//
//  SearchBarExtension.swift
//  FundooApplication
//
//  Created by BridgeLabz on 05/08/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//
//

import UIKit

extension DisplayNotesController : UISearchBarDelegate{
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        
        
    }
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        isSearching = false
    }
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFilter.removeAll()
        let predicateFilter = searchBar.text!
        searchFilter = listOfNotes.filter( {$0.title.lowercased().range(of: predicateFilter) != nil})
        searchFilter = listOfNotes.filter( {$0.description.lowercased().range(of: predicateFilter) != nil})
        isSearching = (searchFilter.count == 0) ? false:true
        collectionView.reloadData()
        
    }
}

