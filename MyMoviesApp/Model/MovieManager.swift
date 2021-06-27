//
//  MovieManager.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/25/21.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateMovies(movies: MoviesData)
}
protocol MovieDataSource {
    func getMovies(filteredBy type: filterType)
    func getFavourites()
}


struct MovieManager: MovieDataSource {
    
    var delegate: MovieManagerDelegate?
    
    let baseURL = "https://api.themoviedb.org/3/discover/movie?language=en-US&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"

//    let sortingType = "popularity.desc"
    
    var key: String? {
        var keys: NSDictionary?

        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            let key = dict["TMDBKey"] as? String
            return key
        }
        return nil
    }
    
//    func getMovies() {
//
//        //TODO: change explisit Key!
//        let movieURL = "\(baseURL)&api_key=\(key!)"
//        fetchData(urlString: movieURL)
//    }
//
    func getMovies(filteredBy type: filterType = .popularity) {
        
        //TODO: change explisit Key!
        let movieURL = "\(baseURL)&api_key=\(key!)\(getFilterString(type: type))"
        fetchData(urlString: movieURL)
    }
    
    func fetchData(urlString: String) {
       
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //TODO: handle error not print
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let movies = parseJSON(movieData: safeData) {
                        delegate?.didUpdateMovies(movies: movies)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(movieData: Data) -> MoviesData? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(MoviesData.self, from: movieData)
        } catch  {
            //TODO: Error
            print(error)
        }
        return nil
    }
    
    func getFavourites() {
        let favMovies = MoviesData(page: 0, results: FavouritesManager.loadFavouriteMovies())
        delegate?.didUpdateMovies(movies: favMovies)
    }
        
}

enum filterType {
    case popularity
    case topRated
}

func getFilterString(type: filterType) -> String {
    switch type {
    case .popularity:
        return "&sort_by=popularity.desc"
    case .topRated:
        return "&sort_by=vote_average.desc"
    }
}

