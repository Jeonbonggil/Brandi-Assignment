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
    var apiManager = APIManager()       // API 통신 클래스
    var searchOption = SearchOption()   // 검색 옵션 모델
    var fetchingMore = false            // 데이터 더 불러오기 플래그
    var savedData = Array<Document>()   // 페이징 했을때, 검색결과가 더 이상 없을 경우 데이터 저장
    let bag = DisposeBag()
    
    weak var delegate: SearchResultDelegate? = nil  // ViewController에 전달할 delegate
    
    /// CollectionView Bind용 모델 변수
    var documentModel = BehaviorSubject<[Document]>(value: [])
    
    let _document = BehaviorRelay<Array<Document>?>(value: nil)
    var document: Driver<Array<Document>?> {
        return _document.asDriver()
    }
    
    /// 검색 API 호출 함수
    func search(searchOption: SearchOption) {
        fetchingMore = true
        
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
                self.fetchingMore = false
            }).disposed(by: bag)
    }
    
    /// ImageDetailViewController 전달할 데이터 함수
    func presentDetail(_ data: Document) {
        delegate?.sendData(data)
    }
    
    // ImageDetailViewController 노출할 datetime format 함수
    func dateFormat(date: String) -> String {
        let format = DateFormatter()
        format.timeZone = NSTimeZone(name: "Asia/Seoul") as TimeZone?
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        format.locale = Locale(identifier: "ko-KR")
        
        guard let dateTime = format.date(from: date) else { return "" }
        format.dateFormat = "yyy-MM-dd HH:mm"
        let time = format.string(from: dateTime)
        
        return time
    }
    
}




