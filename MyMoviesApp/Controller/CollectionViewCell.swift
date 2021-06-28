//
//  CollectionViewCell.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/28/21.
//

import UIKit
import MapleBacon


class CollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configure(with movieName: String, imageUrl: String?) {
        
        let url = URL(string: "\(Constants.Connection.imageBaseString)\(imageUrl ?? "")")
        posterImageView.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        
    }
    
}
