//
//  APIError.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/30.
//

import Foundation

enum APIError: Error {
    case noData
    case error(code: String?, message: String? = nil)

    var localizedDescription: String { return message() }

    func message() -> String {
        switch self {
        case .noData:
            print("No data")
            return "No data"
        case let .error(code, message):
            let unexpectedMsg = "Unexpected failure"
            
            guard let code = code else {
                print(unexpectedMsg)
                return unexpectedMsg
            }
            
            if let message = message {
                print(message)
                return message
            }
            
            switch code {
            case "400":
                return message!
            default:
                return unexpectedMsg
            }
        }
    }
    
}
