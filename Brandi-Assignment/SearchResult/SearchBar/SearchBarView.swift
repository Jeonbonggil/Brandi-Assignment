//
//  SearchBarView.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import Foundation
import UIKit
import RxSwift

class SearchBarView: UISearchBar {
    var searchOption = SearchOption()
    var viewModel: SearchResultViewModel?
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
    }
}

extension SearchBarView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        autoSearch(searchBar)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        autoSearch(searchBar)
    }
}

extension SearchBarView {
    func setViewModel(_ viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
    }
    
    func autoSearch(_ searchBar: UISearchBar) {
        searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self, let viewModel = self.viewModel, let query = searchBar.searchTextField.text else { return }
                self.searchOption.query = query.trimmingCharacters(in: .whitespacesAndNewlines)  // 검색어 공백 제거
                viewModel.searchOption.query = self.searchOption.query
                viewModel.searchOption.size = 30
                viewModel.search(searchOption: self.searchOption)   // 검색 API 호출
            }).disposed(by: bag)
    }
}
