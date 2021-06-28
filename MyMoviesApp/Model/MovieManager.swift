//
//  MovieManager.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/25/21.
//

import Foundation


struct MovieManager: MovieDataSource {

    let connection = ConnectoinManager()
    let favouriteManager = FavouritesManager()
    var delegateMM: MovieManagerDelegate?
    var delegateMD: MovieDetailsDelegate?
    
    let baseURL = Constants.Connection.baseURL
    
    var key: String {
        let path = Bundle.main.path(forResource: Constants.Connection.keyResourseName, ofType: Constants.Connection.keyStorageType )!
        let keys = NSDictionary(contentsOfFile: path)!
        let keyString = keys[Constants.Connection.keyName] as! String
        let finalString = Constants.Connection.keyStringStart + keyString
        
        return finalString
    }

    func getMovies(filteredBy type: SortType = .popularity) {
        let movieURL = baseURL+key+getFilterString(type: type)
        connection.fetchData(urlString: movieURL, successCallback: delegateMM?.getMoviesSucceeded, errorCallback: delegateMM?.getMoviesFailed)
    }
    
    func getFavourites() {
        do {
            let favMovies = try  MoviesData(page: 0, results: favouriteManager.loadFavouriteMovies())
            delegateMM?.getMoviesSucceeded(movies: favMovies)
        } catch {
            delegateMM?.getMoviesFailed(error: error)
        }
    }
    
    func getMovieDetails(id: Int) {
        let movieDetailsUrl = Constants.Connection.movieDetailsBaseString+String(id)+"?"+key
        connection.fetchData(urlString: movieDetailsUrl, successCallback: delegateMD?.getMovieDetailsSucceeded, errorCallback: delegateMD?.getMovieDetailsFailed)
    }
        
    func getFilterString(type: SortType) -> String {
        switch type {
        case .popularity:
            return Constants.Connection.sortByPopularityString
        case .topRated:
            return Constants.Connection.sortByTrandingString
        }
    }
}
