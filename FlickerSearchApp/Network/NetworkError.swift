//
//  NetworkError.swift
//  FlickerSearchApp
//
//  Created by Admin on 04/03/2022.
//

import Foundation
enum NetworkError: Error, LocalizedError {
    case badURL
    case other(Error)
    case serverError
    case dataError
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "This is a bad URL"
        case .serverError:
            return "Server returned an error"
        case .dataError:
            return "No data was returned by the request!"
        case .other(let error):
            return error.localizedDescription
        }
    }
    
}
