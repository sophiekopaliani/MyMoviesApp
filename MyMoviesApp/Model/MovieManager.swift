//
//  MovieManager.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/25/21.
//

import Foundation

protocol MovieDataSource {
    func getMovies()
}

struct MovieManager: MovieDataSource {
    
    let baseURL = "https://api.themoviedb.org/3/discover/movie?language=en-US&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate&sort_by=popularity.desc"

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
    
    func getMovies() {
        
        //TODO: change explisit Key!
        let movieURL = "\(baseURL)&api_key=\(key!)"
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
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString!)
                }
            }
            task.resume()
        }
    }
    
    
}
