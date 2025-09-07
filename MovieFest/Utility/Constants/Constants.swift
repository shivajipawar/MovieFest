//
//  Constants.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/09/25.
//

import Foundation

enum API {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "93d33998099812f88a57c27a3fa05551"
}

enum MovieServiceType {
    case urlSession
    case alamofire
    
    var serviceInstance: MovieService {
        switch self {
        case .urlSession:
            return MovieServiceImpl()
        case .alamofire:
            return MovieServiceImplWithAlamofire()
        }
    }
}
