//
//  MovieManagerDelegate.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import Foundation

protocol MovieManagerDelegate {
    func getMoviesSucceeded(movies: MoviesData)
    func getMoviesFailed(error: Error)
}
