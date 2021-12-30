//
//  mainView.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import UIKit
import RxSwift

class SearchResultView: UIView {
    @IBOutlet weak var searchBar: SearchBarView!
    @IBOutlet weak var collectionView: SearchResultCollectionView!
    @IBOutlet weak var noDataView: UIView!  // 검색결과 없음 View
    
    var viewModel: SearchResultViewModel?
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension SearchResultView {
    func setViewModel(_ viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        searchBar.setViewModel(viewModel)
        collectionView.setViewModel(viewModel)
        
        viewModel.document.drive(onNext: { [weak self] response in
            guard let self = self, (response?.count ?? 0) > 0 else {
                if viewModel.savedData.count == 0 {
                    self?.showNoDataView()
                }
                
                self?.collectionView?.reloadData()
                return
            }
            
            self.hiddenNoDataView()
            self.collectionView?.reloadData()
            print("response \(String(describing: response))")
        }).disposed(by: bag)
    }
    
    /// 검색결과 없음 View 노출
    func showNoDataView() {
        noDataView.isHidden = false
    }
    
    /// 검색결과 없음 View 비노출
    func hiddenNoDataView() {
        noDataView.isHidden = true
    }
}
