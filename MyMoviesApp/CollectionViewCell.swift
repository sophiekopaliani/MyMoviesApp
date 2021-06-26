//
//  CollectionViewCell.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/26/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    func configure(with movieName: String) {
        movieNameLabel.text = movieName
    }
    
}
