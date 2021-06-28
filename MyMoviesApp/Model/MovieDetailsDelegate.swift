//
//  MovieDetailsDelegate.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import Foundation

protocol MovieDetailsDelegate {
    func getMovieDetailsSucceeded(movie: Movie)
    func getMovieDetailsFailed(error: Error)
}
