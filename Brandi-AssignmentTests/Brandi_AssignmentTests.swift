//
//  Brandi_AssignmentTests.swift
//  Brandi-AssignmentTests
//
//  Created by Bonggil Jeon on 2021/12/30.
//

import XCTest
import RxSwift
import RxCocoa

@testable import Brandi_Assignment

class Brandi_AssignmentTests: XCTestCase {
    
    var searchOption = SearchOption()
    let apiManager = APIManager()
    let bag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestSearch() throws {
        // 1. given
        let exp = expectation(description: "Timeout")
        
        // 2. when
        searchOption.query = "넷플릭스"
        searchOption.size = 1000
        apiManager.requsetSearch(searchOption: searchOption)
            .observe(on: MainScheduler.instance)
            .retry(3)
            .subscribe(onNext: { response in
                // 3. then
                print("test response = \(String(describing: response))")
                exp.fulfill()
            }).disposed(by: bag)
        
        wait(for: [exp], timeout: 30)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
