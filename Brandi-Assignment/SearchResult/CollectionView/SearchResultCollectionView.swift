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
                self?.viewModel?.presentDetail(document)
            }.disposed(by: bag)
        
        rx.contentOffset
            .subscribe { [weak self] _ in
                guard let self = self, let viewModel = self.viewModel else { return }
                let offsetY = self.contentOffset.y
                let contentHeight = self.contentSize.height
                
                // 스크롤이 끝에 닿으면 데이터 더 불러오기
                if offsetY > contentHeight - self.frame.height {
                    if !viewModel.fetchingMore {
                        viewModel.searchOption.size += 30
                        viewModel.search(searchOption: viewModel.searchOption)
                    }
                }
            }.disposed(by: bag)
    }
    
}

extension SearchResultCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 30.0) / 3.0
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}
