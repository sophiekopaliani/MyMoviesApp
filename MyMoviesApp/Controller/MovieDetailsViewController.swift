//
//  MovieDetailsViewController.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/26/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = selectedMovie?.original_title
        describtionLabel.text = selectedMovie?.overview
        var ratingString = ""
        if let rating = selectedMovie?.popularity {
            ratingString = "\(rating)"
        }
        ratingLabel.text = ratingString
        dateLabel.text = selectedMovie?.release_date
        
        posterImageView.loadImage(with: selectedMovie?.poster_path)
        
    }
}
