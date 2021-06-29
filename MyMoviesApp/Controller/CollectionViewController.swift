//
//  CollectionViewController.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/26/21.
//

import UIKit

class CollectionViewController: UICollectionViewController, MovieManagerDelegate {

    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    var refresher: UIRefreshControl!
    var movieManager: MovieDataSource!
    var dataSource: [Movie] = []
    var sortType: SortType = .POPULAR
    var paging: Int = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher = UIRefreshControl()
        movieManager = MovieManager()
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView!.refreshControl = refresher
        movieManager.delegateMM = self
        getMovies()
    }
    @objc func refresh() {
        //collectionView!.refreshControl!.beginRefreshing()
        paging = 1
        if sortSegment.selectedSegmentIndex != 2 {
            getMovies()
        } else {
            reloadFavourites()
        }
        collectionView!.refreshControl!.endRefreshing()
    }

    override func viewDidAppear(_ animated: Bool) {
        if sortSegment.selectedSegmentIndex == 2 {
            reloadFavourites()
        }
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        dataSource = []
        paging = 1
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        if sender.selectedSegmentIndex == 0 {
            sortType = .POPULAR
            getMovies()
        } else if sender.selectedSegmentIndex == 1 {
            sortType = .TOP_RATED
            getMovies()
        } else {
            movieManager.getFavourites()
        }
        
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
        
        DispatchQueue.main.async {
            error.presentErr(vc: self, retryAction: self.refresh)
        }
    }
    
    func getMovies() {
        movieManager.getMovies(filteredBy: sortType, page: paging)
    }
    
    func reloadFavourites() {
        dataSource = []
        movieManager.getFavourites()
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
            getMovies()
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


