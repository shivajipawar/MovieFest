//
//  HomeScreen.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/09/25.
//

import SwiftUI

struct HomeScreen: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .center, spacing: 20 ) {
                Text("🎬 MovieFest")
                    .font(.largeTitle)
                    .bold()
                
                Button("Fetch with URLSession") {
                    path.append(MovieServiceType.urlSession)
                }
                .buttonStyle(.borderedProminent)
                
                Button("Fetch with Alamofire") {
                    path.append(MovieServiceType.alamofire)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Home")
            .navigationDestination(for: MovieServiceType.self) { service in
                MovieListView(
                    viewModel: MoviesViewModel(
                        movieService: service.serviceInstance
                    )
                )
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
