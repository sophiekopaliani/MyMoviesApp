//
//  CollectionViewCell.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/26/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var movieImageView: UIImageView!
    
    func configure(with movieName: String, imageUrl: String?) {
     
        movieImageView.loadImage(with: imageUrl)
    }
    
}
