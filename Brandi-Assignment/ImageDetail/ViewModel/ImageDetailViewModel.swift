//
//  ImageDetailViewModel.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2022/01/03.
//

import Foundation

class ImageDetailViewModel {
    let apiManager: APIManager       // API 통신 클래스
    let searchOption: SearchOption   // 검색 옵션 모델
    let isFetchingMore: Bool         // 데이터 더 불러오기 플래그
    let document: Array<Document>    // 페이징 했을때, 검색결과가 더 이상 없을 경우 데이터 저장
    let index: Int
    
    static let EMPTY = ImageDetailViewModel(api: APIManager(),
                                            search: SearchOption(),
                                            isFetchingMore: false,
                                            document: [],
                                            index: 0)
    
    init(api: APIManager,
         search: SearchOption,
         isFetchingMore: Bool,
         document: [Document],
         index: Int) {
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
