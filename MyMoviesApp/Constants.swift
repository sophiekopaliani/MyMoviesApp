//
//  Constants.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/28/21.
//

import Foundation

struct Constants {
     struct Connection {
        static let baseURL = "https://api.themoviedb.org/3/discover/movie?language=en-US&include_adult=false&include_video=false&with_watch_monetization_types=flatrate"
        static let pagingStringStart = "&page="
        static let keyResourseName = "Keys"
        static let keyStorageType = "plist"
        static let keyName = "TMDBKey"
        static let keyStringStart = "&api_key="
        static let sortByPopularityString = "&sort_by=popularity.desc"
        static let sortByTrandingString = "&sort_by=vote_average.desc"
        static let imageBaseString = "https://image.tmdb.org/t/p/w500"
        static let movieDetailsBaseString = "https://api.themoviedb.org/3/movie/"
    }
    static let collectionCellIdentifier = "Cell"
    static let movieDetailsSegue = "goToMovieDetails"
}
