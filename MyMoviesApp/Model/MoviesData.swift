//
//  MoviesData.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/26/21.
//

import Foundation

struct MoviesData: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String
    let overview: String
    let original_title: String
    let popularity: Double
  //  let vote_average: Double
    let release_date: String?
}
