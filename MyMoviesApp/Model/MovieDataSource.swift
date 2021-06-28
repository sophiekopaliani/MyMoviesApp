//
//  MovieDataSource.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import Foundation

protocol MovieDataSource {
    func getMovies(filteredBy type: SortType)
    func getFavourites()
    func getMovieDetails(id: Int)
}
