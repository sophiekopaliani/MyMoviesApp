//
//  CollectionViewController.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/26/21.
//

import UIKit

class CollectionViewController: UICollectionViewController, MovieManagerDelegate {

    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    var movieManager: MovieDataSource = MovieManager()
    var dataSource: [Movie] = []
    var sortType: SortType = .popularity
    var paging: Int = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.delegateMM = self
        movieManager.getMovies(filteredBy: sortType)
    }

    override func viewDidAppear(_ animated: Bool) {
        if sortSegment.selectedSegmentIndex == 2 {
            dataSource = []
            movieManager.getFavourites()
        }
        
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        dataSource = []
        
        if sender.selectedSegmentIndex == 0 {
            sortType = .popularity
            movieManager.getMovies(filteredBy: sortType)
        } else if sender.selectedSegmentIndex == 1 {
            sortType = .topRated
            movieManager.getMovies(filteredBy: sortType)
        } else {
            movieManager.getFavourites()
        }
        paging = 1
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    func getMoviesSucceeded(movies: MoviesData) {
        dataSource.append(contentsOf: movies.results)
        paging += 1
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.row == self.dataSource.count - 3 && sortSegment.selectedSegmentIndex != 2 {
            movieManager.addMovies(filteredBy: sortType, page: paging)
        }
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


