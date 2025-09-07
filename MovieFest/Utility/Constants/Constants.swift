//
//  Constants.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/09/25.
//

import Foundation

enum API {
    static let baseURL = "https://api.themoviedb.org/3"
    static var apiKey : String{
        get {
            guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
                print("Key Not Found")
                return ""
            }
            return apiKey
        }
    }
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
