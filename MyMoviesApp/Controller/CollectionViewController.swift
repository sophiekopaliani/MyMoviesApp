//
//  CollectionViewController.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/26/21.
//

import UIKit

class CollectionViewController: UICollectionViewController, MovieManagerDelegate {
    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    var movieManager = MovieManager()
    var dataSource: [Movie] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.delegateMM = self
        movieManager.getMovies()
    }

    override func viewDidAppear(_ animated: Bool) {
        if sortSegment.selectedSegmentIndex == 2 {
            movieManager.getFavourites()
        }
        
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            movieManager.getMovies(filteredBy: .popularity)
        } else if sender.selectedSegmentIndex == 1 {
            movieManager.getMovies(filteredBy: .topRated)
        } else {
            movieManager.getFavourites()
        }
    }
    
    func getMoviesSucceeded(movies: MoviesData) {
        dataSource = movies.results
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getMoviesFailed(error: Error) {
        error.presentErr(vc: self)
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell = UICollectionViewCell()
        
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCellIdentifier, for: indexPath) as? CollectionViewCell {
            
            movieCell.configure(with: dataSource[indexPath.row].title, imageUrl: dataSource[indexPath.row].poster_path)
            cell = movieCell
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.movieDetailsSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MovieDetailsViewController
        let indexPath = collectionView.indexPathsForSelectedItems?.first
        destinationVC.movieId = dataSource[indexPath?.row ?? 0].id
    }    
}


