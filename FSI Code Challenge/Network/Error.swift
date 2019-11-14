//
//  Error.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import Foundation

protocol FSIError: Error, CustomStringConvertible { }

enum NetworkError: FSIError {
    case noConnection
    case formationError(url: String)
    case errorCode(code: Int)
    case invalidStatus
    case unknownError
    
    var description: String {
        switch self {
        case .noConnection:
            return "No internet connection detected."
        case .formationError(let url):
            return "Failed to form a correct URL for path \(url)"
        case .errorCode(let code):
            return "There was a network error, server returned response code - \(code)"
        case .invalidStatus:
            return "There was an error returned by the API"
        case .unknownError:
            return "An unknown error has occured"
        }
    }
}

enum DecodeError<T>: FSIError {
    case decode(error: Error)
    
    var description: String {
        switch self {
        case .decode(let error):
            return "Decoding model of type \(T.self) failed with error \(error.localizedDescription)"
        }
    }
}
