//
//  MovieDetailsViewController.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/26/21.
//

import UIKit
import CoreData

class MovieDetailsViewController: UIViewController, MovieDetailsDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let favouriteManager = FavouritesManager()
    var movieManager = MovieManager()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var movie: Movie?
    var movieId: Int?
    var movieIsFavourite = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        movieManager.delegateMD = self
        
        if let id = movieId {
            movieManager.getMovieDetails(id: id)
            movieIsFavourite = favouriteManager.movieIsFavourite(with: id)
        }
        favouriteButton.isSelected = movieIsFavourite
    }
    @IBAction func faivouritesButtonPressed(_ sender: UIButton) {
        
        if let movie = movie {
            do {
                if favouriteButton.isSelected {
                    try favouriteManager.removeMovieFromFavourites(movie.id)
                    
                } else {
                    try favouriteManager.saveMovieToFavourites(movie)
                }
            } catch {
                error.presentErr(vc: self)
            }
            favouriteButton.isSelected = !favouriteButton.isSelected
        }
    }
    
    func getMovieDetailsSucceeded(movie: Movie) {
        self.movie = movie
        displayMovieInfo()
    }
    
    func getMovieDetailsFailed(error: Error) {
        error.presentErr(vc: self)
    }
    
    func displayMovieInfo() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.movie?.original_title
            self.describtionLabel.text = self.movie?.overview
            self.ratingLabel.text = "\(self.movie?.popularity ?? 0)"
            self.dateLabel.text = self.movie?.release_date
            self.posterImageView.loadImage(with: self.movie?.poster_path)
        }
    }
    
}
