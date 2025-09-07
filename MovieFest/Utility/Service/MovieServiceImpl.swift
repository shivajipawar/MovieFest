//
//  MovieServiceImpl.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/09/25.
//

import Foundation

final class MovieServiceImpl:MovieService{
    
    func fetchPopularMovies(completion: @escaping (Result<MovieList, Error>) -> Void) {
        
        guard let url = URL(string: "\(API.baseURL)/movie/popular?api_key=\(API.apiKey)") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }
            
            do{
                let moviewListData = try JSONDecoder().decode(MovieList.self, from: data)
                completion(.success(moviewListData))
            }
            catch {
                
            }
        }
        task.resume()
    }
}
