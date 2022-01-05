//
//  ImageDetailViewModel.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2022/01/03.
//

import Foundation

class ImageDetailViewModel {
    var apiManager = APIManager()       // API 통신 클래스
    var searchOption = SearchOption()   // 검색 옵션 모델
    var isFetchingMore = false            // 데이터 더 불러오기 플래그
    var document = Array<Document>()   // 페이징 했을때, 검색결과가 더 이상 없을 경우 데이터 저장
    var index = 0
    
    static let EMPTY = ImageDetailViewModel(api: APIManager(),
                                            search: SearchOption(),
                                            isFetchingMore: false,
                                            document: Array<Document>(), index: 0)
    
    init(api: APIManager = APIManager(),
         search: SearchOption = SearchOption(),
         isFetchingMore: Bool = false,
         document: [Document] = Array<Document>(),
         index: Int = 0) {
        self.apiManager = api
        self.searchOption = search
        self.isFetchingMore = isFetchingMore
        self.document = document
        self.index = index
    }
    
    /// ImageDetailViewController 노출할 datetime format 함수
    func dateFormat(_ date: String) -> String {
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
