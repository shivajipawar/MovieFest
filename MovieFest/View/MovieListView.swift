//
//  MovieListView.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/08/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel: MoviesViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading movies...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text("❌ Error: \(error)")
                        .foregroundColor(.red)
                    Button("Retry") {
                        viewModel.loadMovies(forceReload: true)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(viewModel.moviewList, id: \.id) { movie in
                    NavigationLink(value: movie) {
                        HStack(spacing: 12) {
                            AsyncImage(url: movie.modifiedPosterURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 60, height: 90)
                            .cornerRadius(6)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(movie.title)
                                    .font(.headline)
                                    .lineLimit(1)
                                Text(movie.release_date)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Popular Movies")
        .navigationBarTitleDisplayMode(.inline)
        // Navigation to details
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailsView(movie: movie)
        }
    }
}


struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(
            viewModel: MoviesViewModel(
                movieService: MovieServiceType.alamofire.serviceInstance
            )
        )
    }
}
