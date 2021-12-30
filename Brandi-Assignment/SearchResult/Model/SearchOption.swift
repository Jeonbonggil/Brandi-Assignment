//
//  SearchOption.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/29.
//

import Foundation

// 검색 옵션
struct SearchOption {
    var query: String   // 검색을 원하는 질의어, 필수
    var sort: String    // 결과 문서 정렬 방식, accuracy(정확도순) 또는 recency(최신순), 기본 값 accuracy
    var page: Int       // 결과 페이지 번호, 1~50 사이의 값, 기본 값 1
    var size: Int       // 한 페이지에 보여질 문서 수, 1~80 사이의 값, 기본 값 80
    
    init() {
        query = ""
        sort = "accuracy"
        page = 1
        size = 30
    }
}
