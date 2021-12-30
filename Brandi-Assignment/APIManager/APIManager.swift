//
//  APIManager.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import Foundation
import RxSwift

private let api_key = "KakaoAK a16111ad4f24de1440a185272d875894"

struct APIManager {
    var searchAPI = ""
    
    init() {
        searchAPI = "https://dapi.kakao.com/v2/search/image"
    }
    
    func requsetSearch(searchOption: SearchOption) -> Observable<[Document]?> {
        let query = searchOption.query
        let sort = searchOption.sort
        let page = String(searchOption.page)
        let size = String(searchOption.size)
        
        var url = URLComponents(string: searchAPI)!
        
        url.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "size", value: size)
        ]
        
        url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.addValue(api_key, forHTTPHeaderField: "Authorization")
        
        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil, let res = response as? HTTPURLResponse {
                    emitter.onError(APIError.error(code: String(describing: res.statusCode), message: error?.localizedDescription))
                    return
                }
                
                guard let data = data,
                      let response = try? JSONDecoder().decode(SearchResultModel.self, from: data) else {
                    emitter.onError(APIError.noData)
                    emitter.onNext(nil)
                    emitter.onCompleted()
                    return
                }
                
                emitter.onNext(response.documents)
                emitter.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}
