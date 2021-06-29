//
//  FavouritesManager.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import UIKit
import CoreData

class FavouritesManager {
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

     func saveMovieToFavourites(_ movie: Movie) throws {

        if getMovieIfFavourite(movie.id) == nil {
            let favouriteMovie = FavouriteMovies(context: context)
            createFavouriteMovie(from: movie, in: favouriteMovie)
            do {
                try context.save()
            } catch  {
                throw error
            }
        }
    }
    
     func loadFavouriteMovies() throws -> [Movie] {
        
        let request: NSFetchRequest<FavouriteMovies> = FavouriteMovies.fetchRequest()
        
        var fetchedData: [FavouriteMovies] = []
        do {
            fetchedData = try context.fetch(request)
        } catch {
            throw error
        }
        
        let fetchedMovies = fetchetDataToArray(fetchedData: fetchedData)

        return fetchedMovies
    }
    
    func removeMovieFromFavourites(_ id: Int) throws {

        if let movie = getMovieIfFavourite(id) {
            context.delete(movie)
            do {
                try context.save()
            } catch  {
                throw error
            }
        }
    }
    
     func getMovieIfFavourite(_ id: Int) -> FavouriteMovies? {
     
        let request: NSFetchRequest<FavouriteMovies> = FavouriteMovies.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))

        var fetchedData: [FavouriteMovies] = []
        do {
            fetchedData = try context.fetch(request)
        } catch {
            return nil
        }
        return fetchedData.first
    }
    
     private func fetchetDataToArray(fetchedData: [FavouriteMovies]) -> [Movie] {
        var fetchedMovies: [Movie] = []
        for movie in fetchedData {
            //TODO: why are they optionals
            let newMovie: Movie = Movie(id: Int(movie.id), title: movie.title!, poster_path: movie.poster_Path, overview: movie.overview!, original_title: movie.original_title!, popularity: movie.popularity, vote_average: movie.vote_average, release_date: movie.release_date)
            fetchedMovies.append(newMovie)
        }
        
        return fetchedMovies
    }
    
    func createFavouriteMovie(from movie: Movie, in favouriteMovie: FavouriteMovies) {
            favouriteMovie.id = Int64(movie.id)
            favouriteMovie.original_title = movie.original_title
            favouriteMovie.overview = movie.overview
            favouriteMovie.popularity = movie.popularity
            favouriteMovie.poster_Path = movie.poster_path
            favouriteMovie.title = movie.title
            favouriteMovie.release_date = movie.release_date
        favouriteMovie.vote_average = movie.vote_average
    }
    
    func movieIsFavourite(with id: Int) -> Bool {
        if getMovieIfFavourite(id) == nil {
            return false
        }
        return true
    }
}
