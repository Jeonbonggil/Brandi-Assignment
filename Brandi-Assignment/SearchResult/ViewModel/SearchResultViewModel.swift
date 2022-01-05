//
//  SearchResultViewModel.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import Foundation
import RxSwift
import RxCocoa

class SearchResultViewModel {
    let apiManager: APIManager       // API 통신 클래스
    var searchOption: SearchOption   // 검색 옵션 모델
    var isFetchingMore: Bool         // 데이터 더 불러오기 플래그
    var savedData: Array<Document>   // 페이징 했을때, 검색결과가 더 이상 없을 경우 데이터 저장
    var index: Int
    
    private let bag = DisposeBag()
    weak var delegate: SearchResultDelegate? = nil  // ViewController에 전달할 delegate
    
    /// CollectionView Bind용 모델 변수
    var documentModel = BehaviorSubject<[Document]>(value: [])
    
    let _document = BehaviorRelay<Array<Document>?>(value: nil)
    var document: Driver<Array<Document>?> {
        return _document.asDriver()
    }
    
    static let EMPTY = SearchResultViewModel(api: APIManager(),
                                             search: SearchOption(),
                                             isFetch: false,
                                             savedData: [],
                                             index: 0)
    
    init(api: APIManager,
         search: SearchOption,
         isFetch: Bool,
         savedData: [Document],
         index: Int) {
        self.apiManager = api
        self.searchOption = search
        self.isFetchingMore = isFetch
        self.savedData = savedData
        self.index = index
    }
    
    /// 검색 API 호출 함수
    func search(_ searchOption: SearchOption) {
        isFetchingMore = true
        
        apiManager.requsetSearch(searchOption: searchOption)
            .observe(on: MainScheduler.instance)
            .retry(3)
            .subscribe(onNext: { [weak self] response in
                guard let self = self,
                      let response = response else {
                    if response?.count == 0 {
                        self?.savedData.removeAll()
                    }
                    
                    self?._document.accept(nil)
                    return
                }
                
                self.documentModel.onNext(response)
                self.savedData = response
                self._document.accept(response)
                self.isFetchingMore = false
            }).disposed(by: bag)
    }
    
    /// 검색결과 더 가져오기
    func searchResultFetchMore(_ colView: UICollectionView?) {
        guard let self = colView else { return }
        let offsetY = self.contentOffset.y
        let contentHeight = self.contentSize.height
        
        // 스크롤이 끝에 닿으면 데이터 더 불러오기
        if offsetY > contentHeight - self.frame.height {
            if !isFetchingMore {
                searchOption.size += 30
                search(searchOption)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.reloadData()
                })
            }
        }
    }
    
    /// ImageDetailViewController 전달할 데이터 함수
    func presentDetail() {
        delegate?.presentVC(self)
    }
    
}

//MARK: - SearchBarView
extension SearchResultViewModel {
    /// 1초 뒤 자동 검색
    func autoSearch(_ searchBar: UISearchBar) {
        searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self, let query = searchBar.searchTextField.text else { return }
                self.searchOption.query = query.trimmingCharacters(in: .whitespacesAndNewlines)  // 검색어 공백 제거
                self.searchOption.size = 30
                self.search(self.searchOption)   // 검색 API 호출
            }).disposed(by: bag)
    }
}


