//
//  MovieDataSource.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import Foundation

protocol MovieDataSource {
    
    var delegateMM: MovieManagerDelegate? { get set }
    func getFavourites()
    func getMovieDetails(id: Int)
    func getMovies(filteredBy type: SortType, page: Int)
}
