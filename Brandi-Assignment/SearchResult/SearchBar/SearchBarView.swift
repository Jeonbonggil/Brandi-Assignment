//
//  SearchBarView.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import Foundation
import UIKit

class SearchBarView: UISearchBar {
    var viewModel: SearchResultViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
    }
}

extension SearchBarView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.autoSearch(searchBar)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.autoSearch(searchBar)
    }
}

extension SearchBarView {
    func setViewModel(_ viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
    }
}
