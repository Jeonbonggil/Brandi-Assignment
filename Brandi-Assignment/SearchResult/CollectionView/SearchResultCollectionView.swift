//
//  SearchResultCollectionView.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import UIKit
import RxSwift
import RxCocoa

class SearchResultCollectionView: UICollectionView {
    var viewModel: SearchResultViewModel?
    var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension SearchResultCollectionView {
    /// ViewModel Setting
    func setViewModel(_ viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        bindRx()
    }
    
    /// CollectionView RxDataSource, RxDelegate
    private func bindRx() {
        viewModel?.documentModel
            .observe(on: MainScheduler.instance)
            .filter { !($0.isEmpty) }
            .bind(to: rx.items(cellIdentifier: "cell",
                               cellType: SearchResultCollectionCell.self)) { index, model, cell in
                cell.updateUI(model)
            }.disposed(by: bag)
        
        Observable.zip(rx.itemSelected, rx.modelSelected(Document.self))
            .bind { [weak self] indexPath, document in
                self?.viewModel?.presentDetail()
            }.disposed(by: bag)
        
        rx.contentOffset
            .subscribe { [weak self] _ in
                self?.viewModel?.searchResultFetchMore(self)
            }.disposed(by: bag)
        
        rx.setDelegate(self).disposed(by: bag)
    }
    
}

extension SearchResultCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 3
        let height = width

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

}
