//
//  Movie.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/08/25.
//

import Foundation

struct Movie: Decodable, Identifiable, Hashable{
    var id: Int
    var adult:Bool
    var backdrop_path:String
    var genre_ids:[Int]
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
    var modifiedPosterURL:URL? {
        get{
            let urlString = "https://image.tmdb.org/t/p/original".appending(poster_path)
            return  URL(string: urlString)!
        }
    }
}
