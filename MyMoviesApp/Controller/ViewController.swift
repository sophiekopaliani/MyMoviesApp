//
//  ViewController.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/25/21.
//

import UIKit

class ViewController: UIViewController {

    let movieManager = MovieManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        movieManager.getMovies()
        
        
    }


}

