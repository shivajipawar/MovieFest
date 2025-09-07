//
//  MoviesViewModel.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/08/25.
//

import Foundation

@MainActor
class MoviesViewModel : ObservableObject{
    @Published var moviewList:[Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private let movieService: MovieService
    
    // ✅ Dependency Injection (protocol-based)
    init(movieService: MovieService) {
        self.movieService = movieService
        loadMovies()   // ✅ Auto fetch once at init
    }
    
    func loadMovies(forceReload: Bool = false) {
        
        // Only fetch if first load OR explicitly retried
        guard moviewList.isEmpty || forceReload else { return }
        
        /*
         // Option 1: Using Completion Handler
        movieService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async { [weak self]  in
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let movies):
                        self.moviewList = movies.results
                case .failure(let error):
                        self.errorMessage = error.localizedDescription
                }
            }
        }
         */
        
        
        // Option 2: Using Continuation - By calling async method
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let movies = try await loadMoviesWithContinuation()
                self.moviewList = movies
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func loadMoviesWithContinuation() async throws -> [Movie]{
        try await withCheckedThrowingContinuation { continuation in
            movieService.fetchPopularMovies { result in
                switch result {
                case .success(let movies):
                    continuation.resume(returning: movies.results)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
