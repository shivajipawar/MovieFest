//
//  MovieService.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/09/25.
//

protocol MovieService{
    func fetchPopularMovies(completion: @escaping (Result<MovieList, Error>) -> Void)
}
