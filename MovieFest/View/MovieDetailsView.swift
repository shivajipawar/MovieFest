//
//  MovieDetailsView.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/08/25.
//

import Foundation
import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: movie.modifiedPosterURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 350)
                .clipped()

                // Back button overlay
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                .padding(.leading, 16)
                .padding(.top, 50) // Safe area offset
            }

            VStack(alignment: .leading, spacing: 12) {
                Text(movie.title)
                    .font(.title)
                    .bold()

                Text("Release: \(movie.release_date)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(movie.overview)
                    .font(.body)
                    .padding(.top, 8)
            }
            .padding()
        }
      //  .navigationBarTitleDisplayMode(.inline) // ✅ smooth inline back transition
        .ignoresSafeArea(edges: .top) // Poster goes under status bar
        .navigationBarBackButtonHidden(true) // ✅ Hide default back button
        .navigationBarHidden(true) // ✅ Hide navigation bar title
    }
}
