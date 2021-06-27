//
//  FavouritesManager.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import UIKit
import CoreData

class FavouritesManager {
   static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   static func saveMovieToFavourites(_ movie: Movie) {

        let favouriteMovie = FavouriteMovies(context: context)

            favouriteMovie.id = Int64(movie.id)
            favouriteMovie.original_title = movie.original_title
            favouriteMovie.overview = movie.overview
            favouriteMovie.popularity = movie.popularity
            favouriteMovie.poster_Path = movie.poster_path
            favouriteMovie.title = movie.title
            favouriteMovie.release_date = movie.release_date

        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    static func loadFavouriteMovies() -> [Movie] {
        let request: NSFetchRequest<FavouriteMovies> = FavouriteMovies.fetchRequest()
        var fetchedData: [FavouriteMovies] = []
        do {
            fetchedData = try context.fetch(request)
        } catch {
            print(error)
        }
        
        var fetchedMovies: [Movie] = []
        
        for movie in fetchedData {
            //TODO: why are they optionals
            let newMovie: Movie = Movie(id: Int(movie.id), title: movie.title!, poster_path: movie.poster_Path, overview: movie.overview!, original_title: movie.original_title!, popularity: movie.popularity, release_date: movie.release_date)

            fetchedMovies.append(newMovie)
        }
        
        print("movies is fetched")
        return fetchedMovies
    }
    
    
}
