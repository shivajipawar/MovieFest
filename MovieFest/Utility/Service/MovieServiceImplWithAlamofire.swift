//
//  MovieServiceImplWithAlamofire.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/09/25.
//

import Foundation
import Alamofire

final class MovieServiceImplWithAlamofire:MovieService{
    
    func fetchPopularMovies(completion: @escaping (Result<MovieList, Error>) -> Void) {
        
        let urlString = "\(API.baseURL)/movie/popular?api_key=\(API.apiKey)"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: MovieList.self) { response in
                switch response.result {
                case .success(let movieResponse):
                    completion(.success(movieResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
