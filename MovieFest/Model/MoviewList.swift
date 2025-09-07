//
//  MoviewList.swift
//  MovieFest
//
//  Created by Shivaji N. Pawar on 07/08/25.
//

import Foundation

struct MovieList: Decodable{
    var page: Int
    var results:[Movie]
    var total_pages: Int
    var total_results: Int
}

